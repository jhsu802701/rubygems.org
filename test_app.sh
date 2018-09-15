#!/bin/bash

echo '----------------------------------'
echo 'sudo service elasticsearch restart'
sudo service elasticsearch restart

echo '--------------------------------'
echo 'sudo service memcached restart'
sudo service memcached restart

echo '--------------'
echo 'bundle install'
bundle install

echo '----------------------------------------------------------------------------'
echo 'bundle exec rake environment elasticsearch:import:all DIR=app/models FORCE=y'
bundle exec rake environment elasticsearch:import:all DIR=app/models FORCE=y

echo '----------------'
echo 'rails db:migrate'
rails db:migrate

echo '----------'
echo 'rails test'
rails test
