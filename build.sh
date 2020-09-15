#!/bin/bash

RUBY_VERSION=`cat .ruby-version`
BUNDLER_VERSION='2.1.4'

echo '-------------------------'
echo "rvm install $RUBY_VERSION"
rvm install $RUBY_VERSION
wait

echo '---------------------'
echo "rvm use $RUBY_VERSION"
rvm use $RUBY_VERSION
wait

echo '-------'
echo 'ruby -v'
ruby -v

echo '---------------------------------------'
echo "gem install bundler -v $BUNDLER_VERSION"
gem install bundler -v $BUNDLER_VERSION
wait

echo '--------------'
echo 'bundle install'
bundle install
wait

echo '--------------'
echo './script/setup'
./script/setup

echo '-----------------------------'
echo './script/install_toxiproxy.sh'
./script/install_toxiproxy.sh

echo '-------------------------'
echo 'bundle exec rake db:setup'
bundle exec rake db:setup
