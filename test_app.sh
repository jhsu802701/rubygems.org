#!/bin/bash

sh pg-restart.sh

echo '--------------'
echo 'bundle install'
bundle install

echo '------------------------------------------------'
echo 'RAILS_ENV=test bundle exec rake db:migrate:reset'
RAILS_ENV=test bundle exec rake db:migrate:reset

echo '--------------------------------------------------------------------'
echo 'RAILS_ENV=test bundle exec rake db:create db:migrate db:test:prepare'
RAILS_ENV=test bundle exec rake db:create db:migrate db:test:prepare
