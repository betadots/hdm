FROM ruby:3.3.6-alpine3.20

RUN apk update \
    && apk upgrade \
    && apk add --no-cache --update \
        git \
        sqlite \
        alpine-sdk \
        libxml2-dev \
        libxslt-dev \
        tzdata \
        bash \
        gcompat

ENV APP_HOME /hdm
ENV RAILS_ENV production
ENV HDM_PORT 3000
ENV HDM_HOST 0.0.0.0
ENV RUBYOPT="--yjit"

EXPOSE $HDM_PORT

WORKDIR $APP_HOME

COPY . $APP_HOME
COPY config/hdm.yml.template $APP_HOME/config/hdm.yml

RUN bundle check || (bundle config set --local without 'development test' && bundle install)

CMD ["sh", "-c", "/hdm/bin/entry.sh ${HDM_PORT} ${HDM_HOST}"]
