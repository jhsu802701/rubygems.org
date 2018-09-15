#!/bin/bash

echo 'Welcome to the unofficial build script of the rubygems.org site!'
echo 'This script assumes that you are using the Ruby on Racetracks'
echo 'system to work on'
echo 'this project and that you are using the pre-installed tmux tool'
echo 'to provide simultaneous multiple windows to interact with the'
echo 'same Docker container.'
echo ''
echo 'The purpose of this script is to allow you to quickly and efficiently'
echo 'set up this project.  Setting up the project so that all tests pass'
echo 'will be something you can do in minutes instead of hours.'
echo ''
echo 'Before you continue, please do the following:'
echo '1. If you are not in a tmux window, stop this script, run tmux,'
echo '   and run this script again.'
echo '2. Start a second tmux window, and start the Redis server.  Enter'
echo '   the command "cd rubygems.org; redis-server".'
echo '3. Start a third tmux window to set up the database and run'
echo '   Toxiproxy.  Enter the command "cd rubygems.org && sh toxiproxy.sh".'
echo '   PLEASE NOTE that it will take a few minutes to install Toxiproxy.'
echo '   Do NOT continue this build script UNTIL Toxiproxy is running.'
echo '4. Start a fourth tmux window for entering additional commands.'
echo '--------------------------------------------------------------'
echo 'When you have satisfied the above requirements, press ENTER to' 
echo 'continue.'
echo 'Otherwise, press Ctrl-C to exit.'
echo '--------------------------------'
read cont
echo 'Continuing . . . .'

sh kill_spring.sh

echo '----------------------------------------'
echo 'bundle exec rake db:test:prepare --trace'
bundle exec rake db:test:prepare --trace

sh all.sh
