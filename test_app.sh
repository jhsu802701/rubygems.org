#!/bin/bash

echo '--------------'
echo 'bundle install'
bundle install

echo '-------------------------------------------'
echo 'bundle exec rake db:migrate db:test:prepare'
bundle exec rake db:migrate db:test:prepare

echo '----------------------------------------------------------------------------'
echo 'bundle exec rake environment elasticsearch:import:all DIR=app/models FORCE=y'
bundle exec rake environment elasticsearch:import:all DIR=app/models FORCE=y

# NOTE: The Spring server may distort the test coverage results from MiniTest and SimpleCov.
echo '---------------------------'
echo 'DISABLE_SPRING=1 rails test'
DISABLE_SPRING=1 rails test

