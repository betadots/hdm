#!/usr/bin/env bash

HDM_PORT=$1
HDM_HOST=$2

bundle exec rake db:setup
bundle exec rake hdm:assets

if [[ "${DEVELOP}" -eq 1 ]]; then
bundle exec rails db:seed
./bin/fake_puppet_db &
fi

bundle exec rails server -b $HDM_HOST -p $HDM_PORT
