#!/bin/bash

#####################
# BEGIN: manual steps
#####################

echo 'Welcome to the unofficial build script of the Rubygems.org site!'
echo 'This script assumes that you are using the Ruby on Racetracks'
echo 'protocols to work on this project.'
echo ''
echo 'The purpose of this script is to allow you to quickly and efficiently'
echo 'set up this project.  Setting up the project so that all tests pass'
echo 'will be something you can do in minutes instead of hours.'
echo ''
echo 'Before you continue, please do the following:'
echo '1. Start an additional tab in LXTerminal for Toxiproxy.'
echo '   Enter the command "sh join.sh".'   
echo '   After you enter the Docker container, enter the command'
echo '   "cd rubygems.org; sh toxiproxy.sh".'
echo '   In a moment, Toxiproxy will be running.'
echo '--------------------------------------------------------------'
echo 'When you have satisfied the above requirements, press ENTER to' 
echo 'continue.'
echo 'Otherwise, press Ctrl-C to exit.'
echo '--------------------------------'
read cont

########################
# FINISHED: manual steps
########################

###############################
# BEGIN: setup up ElasticSearch
###############################

echo '-------------------------'
echo 'Configuring ElasticSearch'
ES_YML='/etc/elasticsearch/elasticsearch.yml'
sudo bash -c "echo 'http.host: 0.0.0.0' > $ES_YML"
sudo bash -c "echo 'transport.host: 127.0.0.1' >> $ES_YML"
sudo bash -c "echo 'xpack.security.enabled: false' >> $ES_YML"

##################################
# FINISHED: setup up ElasticSearch
##################################

##########################
# BEGIN: set up PostgreSQL
##########################

PG_VERSION="$(ls /etc/postgresql)"
PG_HBA="/etc/postgresql/$PG_VERSION/main/pg_hba.conf"
echo '-------------------'
echo "Configuring $PG_HBA"

sudo bash -c "echo '# TYPE  DATABASE        USER            ADDRESS                 METHOD' > $PG_HBA"
sudo bash -c "echo '' >> $PG_HBA"
sudo bash -c "echo '# Allow postgres user to connect to database without password' >> $PG_HBA"
sudo bash -c "echo 'local   all             postgres                                trust' >> $PG_HBA"
sudo bash -c "echo '' >> $PG_HBA"
sudo bash -c "echo 'local   all             all                                     trust' >> $PG_HBA"
sudo bash -c "echo '' >> $PG_HBA"
sudo bash -c "echo '# Full access to 0.0.0.0 (localhost) for pgAdmin host machine access' >> $PG_HBA"
sudo bash -c "echo '# IPv4 local connections:' >> $PG_HBA"
sudo bash -c "echo 'host    all             all             0.0.0.0/0               trust' >> $PG_HBA"
sudo bash -c "echo '' >> $PG_HBA"
sudo bash -c "echo '# IPv6 local connections:' >> $PG_HBA"
sudo bash -c "echo 'host    all             all             ::1/128                 trust' >> $PG_HBA"

echo '--------------------------------------------------'
echo 'cp config/database.yml.example config/database.yml'
cp config/database.yml.example config/database.yml

sh pg-start.sh

echo '--------------'
echo 'bundle install'
bundle install

echo '----------------------------------------'
echo "sudo -u postgres createuser -d $USERNAME"
sudo -u postgres createuser -d $USERNAME

echo '-----------------------------------'
echo "Make the user $USERNAME a superuser"
psql -c "ALTER USER $USERNAME WITH SUPERUSER;" -U postgres

echo '-----------------------------------------------------------'
echo "psql -c 'create database rubygems_development;' -U postgres"
psql -c 'create database rubygems_development;' -U postgres

echo '----------------------------------------------------'
echo "psql -c 'create database rubygems_test;' -U postgres"
psql -c 'create database rubygems_test;' -U postgres

#############################
# FINISHED: set up PostgreSQL
#############################

sh kill_spring.sh
sh all.sh
