#!/bin/bash

# Epel-Release & MicroCode installation:

sudo dnf install epel-release -y
sudo dnf install iucode-tool -y # Intel MicroCode
sudo dnf install lm_sensors lm_sensors-devel hddtemp -y # Sensors MicroCode
sudo sensors >> sensors.log

# Compile PSensor from source:

sudo dnf install gcc gtk3-devel GConf2-devel cppcheck libatasmart-devel libcurl-devel json-c-devel libmicrohttpd-devel help2man libnotify-devel libgtop2-devel make -y

wget http://wpitchoune.net/psensor/files/psensor-1.2.1.tar.gz
tar zxvf psensor-1.2.1.tar.gz
cd psensor-1.2.1/
./configure
make
make install

# Diagnose hardware:

sudo sensors-detect

# Display Temperatures:

sudo sensors
