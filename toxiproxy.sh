#!/bin/bash

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
sudo bash -c "echo '# IPv4 local connections:' >> $PG_HBA"
sudo bash -c "echo 'host    all             all             0.0.0.0/0               trust' >> $PG_HBA"
sudo bash -c "echo '' >> $PG_HBA"
sudo bash -c "echo '# IPv6 local connections:' >> $PG_HBA"
sudo bash -c "echo 'host    all             all             ::1/128                 trust' >> $PG_HBA"

sh pg-start.sh

echo '--------------'
echo 'bundle install'
bundle install

echo '----------------------------------------------------'
echo "'create database gemcutter_development;' -U postgres"
psql -c 'create database gemcutter_development;' -U postgres

echo '-----------------------------------------------------'
echo "psql -c 'create database gemcutter_test;' -U postgres"
psql -c 'create database gemcutter_test;' -U postgres

echo '----------------'
echo 'rails db:migrate'
rails db:migrate

./script/setup

echo '*****************'
echo 'Running toxiproxy'
echo 'Press Ctrl-C to stop'
echo '********************'
toxiproxy
