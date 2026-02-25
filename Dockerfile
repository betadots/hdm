FROM docker.io/library/ruby:3.4.8-alpine3.23 AS builder

RUN apk update \
    && apk upgrade \
    && apk add --no-cache --update \
        git \
        sqlite \
        alpine-sdk \
        libxml2-dev \
        libxslt-dev \
        yaml-dev \
        tzdata \
        bash \
        libffi-dev # required for the fiddle gem, transitive openvox dependency

ENV APP_HOME=/hdm
WORKDIR $APP_HOME

COPY . $APP_HOME
COPY config/hdm.yml.template $APP_HOME/config/hdm.yml

RUN bundle check || (bundle config set --local without 'development test release' && bundle install)

###############################################################################

FROM docker.io/library/ruby:3.4.8-alpine3.23 AS final

LABEL org.label-schema.maintainer="betadots GmbH" \
      org.label-schema.vendor="betadots GmbH" \
      org.label-schema.url="https://github.com/betadots/hdm" \
      org.label-schema.license="AGPLv3+" \
      org.label-schema.vcs-url="https://github.com/betadots/hdm" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.dockerfile="/Dockerfile" \
      org.label-schema.name="HDM - Hiera Data Manager"

RUN apk update \
    && apk upgrade \
    && apk add --no-cache --update \
        git \
        sqlite \
        tzdata \
        libstdc++ \
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

COPY Dockerfile /
COPY VERSION /

CMD ["sh", "-c", "/hdm/bin/entry.sh ${HDM_PORT} ${HDM_HOST}"]
