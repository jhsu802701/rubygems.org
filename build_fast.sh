#!/bin/bash

echo 'Welcome to the unofficial build script of the rubygems.org site!'
echo 'It is assumed here that you are using the Ruby on Racetracks system.'
echo ''
echo 'The purpose of this script is to allow you to quickly and efficiently'
echo 'set up this project.  Setting up the project so that all tests pass'
echo 'will be something you can do in minutes instead of hours.'
echo ''
echo 'Before you continue, please do the following:'
echo '1. Start a second terminal tab for Toxiproxy.'
echo '   Enter the command "sh join.sh" to enter the Docker container.'
echo '   In Docker, enter the command "cd rubygems.org && sh toxiproxy.sh".'
echo '   PLEASE NOTE that it will take a few minutes to install Toxiproxy.'
echo '   Do NOT continue this build script UNTIL Toxiproxy is running.'
echo '2. Start a third terminal tab for entering other commands.'
echo '   Enter the command "sh join.sh" to enter the Docker container.'
echo '--------------------------------------------------------------'
echo 'When you have satisfied the above requirements, press ENTER to' 
echo 'continue.'
echo 'Otherwise, press Ctrl-C to exit.'
echo '--------------------------------'
read cont
echo 'Continuing . . . .'

sh pg_setup.sh

sh install-elasticsearch.sh

sh kill_spring.sh
sh all.sh
