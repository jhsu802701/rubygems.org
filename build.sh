#!/bin/bash

rvm install `cat .ruby-version`
wait
rvm use `cat .ruby-version`
wait
gem install bundler -v 2.1.4
