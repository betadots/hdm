#!/usr/bin/env bash

bundle exec rake db:setup

if [[ "${DEVELOP}" -eq 1 ]]; then
bundle exec rails db:seed
./bin/fake_puppet_db &
fi

bundle exec rails server -b 0.0.0.0
