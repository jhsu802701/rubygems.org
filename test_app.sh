#!/bin/bash

sh pg-start.sh

echo '--------------'
echo 'bundle install'
bundle install

echo '------------------------------------------------'
echo 'RAILS_ENV=test bundle exec rake db:migrate:reset'
RAILS_ENV=test bundle exec rake db:migrate:reset

echo '--------------------------------------------------------------------'
echo 'RAILS_ENV=test bundle exec rake db:create db:migrate db:test:prepare'
RAILS_ENV=test bundle exec rake db:create db:migrate db:test:prepare

echo '-------------------------------------------------------------------------------------------'
echo 'RAILS_ENV=test bundle exec rake environment elasticsearch:import:all DIR=app/models FORCE=y'
RAILS_ENV=test bundle exec rake environment elasticsearch:import:all DIR=app/models FORCE=y

# NOTE: The Spring server may distort the test coverage results from MiniTest and SimpleCov.
echo '-------------------------'
echo 'RAILS_ENV=test rails test'
RAILS_ENV=test rails test

