#!/bin/bash

echo 'Welcome to the unofficial build script of the rubygems.org site!'
echo 'This script assumes that you are using the Ruby on Racetracks'
echo 'system to work on this project and that you are using the'
echo 'pre-installed tmux tool to provide simultaneous multiple windows'
echo 'to interact with the same Docker container.'
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
echo '   Toxiproxy.  Enter the command "cd rubygems.org; sh toxiproxy.sh".'
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

PG_VERSION="$(ls /etc/postgresql)"
PG_HBA="/etc/postgresql/$PG_VERSION/main/pg_hba.conf"
echo '-------------------'
echo "Configuring $PG_HBA"

sudo bash -c "echo '# Database administrative login by Unix domain socket' > $PG_HBA"
sudo bash -c "echo 'local   all             postgres                                trust' >> $PG_HBA"
sudo bash -c "echo '# TYPE  DATABASE        USER            ADDRESS                 METHOD' >> $PG_HBA"
sudo bash -c "echo '# local is for Unix domain socket connections only' > $PG_HBA"
sudo bash -c "echo 'local   all             all                                     trust' >> $PG_HBA"
sudo bash -c "echo '' >> $PG_HBA"
sudo bash -c "echo '# IPv4 local connections:' >> $PG_HBA"
sudo bash -c "echo 'host    all             all             0.0.0.0/0               trust' >> $PG_HBA"
sudo bash -c "echo '' >> $PG_HBA"
sudo bash -c "echo '# IPv6 local connections:' >> $PG_HBA"
sudo bash -c "echo 'host    all             all             ::1/128                 trust' >> $PG_HBA"

sh pg-start.sh

echo '--------------'
echo "bundle install"
bundle install

sh kill_spring.sh

sh all.sh
