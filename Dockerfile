FROM ruby:3.3.3-slim-bookworm

RUN apt update && apt install -y \
      g++ \
      gcc \
      make \
      libstdc++-12-dev \
      libffi-dev \
      libc-dev \
      libxml2-dev \
      libxslt-dev \
      libgcrypt-dev \
      libsqlite3-dev \
      sqlite3 \
      # not needed for gems, but for runtime
      git \
      tzdata \
      && rm -rf /var/lib/apt/lists/*

ENV APP_HOME /hdm
ENV RAILS_ENV production
ENV HDM_PORT 3000
ENV HDM_HOST 0.0.0.0

EXPOSE $HDM_PORT

WORKDIR $APP_HOME

COPY . $APP_HOME
COPY config/hdm.yml.template $APP_HOME/config/hdm.yml

RUN bundle check || (bundle config set --local without 'development test' && bundle install)

CMD ["sh", "-c", "/hdm/bin/entry.sh ${HDM_PORT} ${HDM_HOST}"]
