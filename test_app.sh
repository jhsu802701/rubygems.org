#!/bin/bash

echo '----------------------------------'
echo 'sudo service elasticsearch restart'
sudo service elasticsearch restart

echo '--------------------------------'
echo 'sudo service memcached restart'
sudo service memcached restart

echo '--------------'
echo "bundle install"
bundle install

echo '--------------------------------------------------'
echo 'cp config/database.yml.example config/database.yml'
cp config/database.yml.example config/database.yml

echo '----'
echo 'wait'
wait

echo '-----------------------------------------------------'
echo 'bundle exec rake db:create db:migrate db:test:prepare'
bundle exec rake db:create db:migrate db:test:prepare

echo '----------'
echo 'rails test'
rails test
