#!/usr/bin/env bash
# exit on error
set -o errexit

chmod +x bin/rails

bundle install

bundle exec rails assets:precompile

bundle exec rails assets:clean

bin/rails db:environment:set RAILS_ENV=production

rake db:migrate

RAILS_ENV=test rake db:migrate
