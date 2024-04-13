#!/bin/bash
set -e
sudo apt-get update -y
sudo apt install openjdk-11-jdk-headless -y
sudo wget http://archive.apache.org/dist/activemq/5.15.8/apache-activemq-5.15.8-bin.tar.gz
sudo tar -xvzf apache-activemq-5.15.8-bin.tar.gz
sudo mv apache-activemq-5.15.8 /opt/activemq
sudo addgroup --quiet --system activemq
sudo adduser --quiet --system --ingroup activemq --no-create-home --disabled-password activemq
sudo chown -R activemq:activemq /opt/activemq
sudo cp ~/activemq.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl start activemq
sudo systemctl enable activemq
sudo systemctl restart activemq
/opt/activemq/bin/activemq status
sudo ufw allow 8161
