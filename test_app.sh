#!/bin/bash

echo '--------------'
echo 'bundle install'
bundle install

echo '-----------------------------------------------------'
echo 'bundle exec rake db:create db:migrate db:test:prepare'
bundle exec rake db:create db:migrate db:test:prepare

# NOTE: The Spring server may distort the test coverage results from MiniTest and SimpleCov.
echo '---------------------------------------'
echo 'DISABLE_SPRING=1 bundle exec rails test'
DISABLE_SPRING=1 bundle exec rails test

