#!/bin/bash

# NOTE: In the Docker environment, PostgreSQL does NOT automatically start.
# As a result, this script is necessary.

echo '-------------------------------'
echo 'sudo service postgresql restart'
sudo service postgresql restart

echo '------------------------------'
echo 'sudo service memcached restart'
sudo service memcached restart

echo '----------------------------------'
echo 'sudo service elasticsearch restart'
sudo service elasticsearch restart
