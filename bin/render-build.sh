#!/usr/bin/env bash
# exit on error
set -o errexit

bundle config set --local without 'development,test,analyze,tools'
bundle install
bundle exec rake db:migrate
