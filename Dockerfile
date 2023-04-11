FROM ruby:3.2.2-slim-bullseye

RUN apt update && apt install -y \
      g++ \
      gcc \
      make \
      libstdc++-10-dev \
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
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

WORKDIR $APP_HOME

COPY . $APP_HOME
COPY config/hdm.yml.template $APP_HOME/config/hdm.yml

RUN bundle check || (bundle config set --local without 'development test' && bundle install)

EXPOSE 3000

CMD ["/hdm/bin/entry.sh"]
