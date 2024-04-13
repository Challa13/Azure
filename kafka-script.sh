#!/bin/bash
sudo apt-get update -y
sleep 3
sudo apt install openjdk-11-jdk-headless -y
sudo wget https://www-eu.apache.org/dist/kafka/3.4.1/kafka_2.13-3.4.1.tgz -O /home/azureuser/kafka_2.13-3.4.1.tgz
tar -xvf /home/azureuser/kafka_2.13-3.4.1.tgz
sudo wget https://www-eu.apache.org/dist/zookeeper/zookeeper-3.7.1/apache-zookeeper-3.7.1-bin.tar.gz -O /home/azureuser/apache-zookeeper-3.7.1-bin.tar.gz
sleep 2
gunzip -f /home/azureuser/apache-zookeeper-3.7.1-bin.tar.gz
sleep 3
tar -xvf apache-zookeeper-3.7.1-bin.tar
sleep 3
sudo chmod -R 755 apache-zookeeper-3.7.1-bin
sudo chmod -R 755 kafka_2.13-3.4.1
export JAVA_HOME="$(dirname $(dirname $(readlink -f $(which java))))"
export PATH=$PATH:$JAVA_HOME/bin
sudo mv /home/azureuser/apache-zookeeper-3.7.1-bin/conf/zoo_sample.cfg /home/azureuser/apache-zookeeper-3.7.1-bin/conf/zoo.cfg
cd /home/azureuser/apache-zookeeper-3.7.1-bin/bin
chmod +x /home/azureuser/apache-zookeeper-3.7.1-bin/bin/zkServer.sh
nohup ./zkServer.sh start &
sleep 30
export key=$(curl https://ipinfo.io/ip ;)
sleep 10
sudo sed -i 's/your.host.name/'$key'/g' /home/azureuser/kafka_2.13-3.4.1/config/server.properties
sleep 10
sudo sed -i 's/localhost/'$key'/g' /home/azureuser/kafka_2.13-3.4.1/config/server.properties
sleep 10
sudo sed -i 's/#listeners/listeners/g' /home/azureuser/kafka_2.13-3.4.1/config/server.properties
sleep 10
sudo sed -i 's/#advertised.listeners/advertised.listeners/g' /home/azureuser/kafka_2.13-3.4.1/config/server.properties
sleep 10
cd /home/azureuser/kafka_2.13-3.4.1/bin
sleep 5
chmod +x /home/azureuser/kafka_2.13-3.4.1/bin/kafka-server-start.sh
sleep 5
cd ~/kafka_2.13-3.4.1
sleep 5
nohup ./bin/kafka-server-start.sh /home/azureuser/kafka_2.13-3.4.1/config/server.properties &
sleep 20
