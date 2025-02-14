FROM docker.io/library/ruby:3.4.1-alpine3.21 AS builder

RUN apk update \
    && apk upgrade \
    && apk add --no-cache --update \
        git \
        sqlite \
        alpine-sdk \
        libxml2-dev \
        libxslt-dev \
        tzdata \
        bash

ENV APP_HOME=/hdm
WORKDIR $APP_HOME

COPY . $APP_HOME
COPY config/hdm.yml.template $APP_HOME/config/hdm.yml

RUN bundle check || (bundle config set --local without 'development test release' && bundle install)

###############################################################################

FROM docker.io/library/ruby:3.4.1-alpine3.21 AS final

RUN apk update \
    && apk upgrade \
    && apk add --no-cache --update \
        git \
        sqlite \
        tzdata \
        bash

ENV APP_HOME=/hdm
ENV RAILS_ENV=production
ENV HDM_PORT=3000
ENV HDM_HOST=0.0.0.0
ENV RUBYOPT="--yjit"

EXPOSE $HDM_PORT

WORKDIR $APP_HOME

# copy only the needed files from the builder image
COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY --from=builder $APP_HOME $APP_HOME

CMD ["sh", "-c", "/hdm/bin/entry.sh ${HDM_PORT} ${HDM_HOST}"]
