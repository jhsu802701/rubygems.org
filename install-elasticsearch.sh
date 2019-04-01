#!/bin/bash

echo 'wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -'
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

echo '---------------------------------------------------------------------------------------------------------------------------'
echo 'echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list'
echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list

echo '-------------------'
echo 'sudo apt-get update'
sudo apt-get update

echo '-------------------------------------'
echo 'sudo apt-get install -y elasticsearch'
sudo apt-get install -y elasticsearch

# echo 'http.host: 0.0.0.0' | sudo tee /etc/elasticsearch/elasticsearch.yml
# echo 'transport.host: 127.0.0.1' | sudo tee -a /etc/elasticsearch/elasticsearch.yml
# echo 'xpack.security.enabled: false' | sudo tee -a /etc/elasticsearch/elasticsearch.yml
