#!/bin/bash

# install Rocket Broadcaster

mkdir -p installs
cd installs
wget https://www.rocketbroadcaster.com/streaming-audio-server/downloads/ubuntu-20.04/rsas_0.1.20-1_amd64.deb
sudo apt-get install -y libogg0
sudo dpkg -i rsas*.deb

# install IceS (for sending syndication playlist to RB)
wget https://downloads.xiph.org/releases/ices/ices-2.0.3.tar.gz
tar -xvzf ices-*.gz
