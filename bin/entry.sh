#!/usr/bin/env sh

# cd /hdm

bundle exec rails db:create
bundle exec rails db:migrate
# bundle exec rails db:seed

# ./bin/fake_puppet_db &
bundle exec rails server -b 0.0.0.0
