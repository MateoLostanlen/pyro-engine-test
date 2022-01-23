#!/bin/bash
# This script performs:
# Ping google.com:
#	- if success:
#		Ping internal vpn ip:
#		- if success: ok exit
#		- if failure: restart vpn
#
#	- if failure: restart of network interfaces
# Sleep 60 sec
# Ping google again (to make sure that we have internet):
#	- if success: ok exit
#	- if failure: reboot

set -u
echo $(date +"%H:%M:%S") >> '/home/pi/test.txt';
PING_CMD=('ping' '-c' '1' '-W' '10' 'google.com')

if "${PING_CMD[@]}";
then
    echo 'ok 1' >> '/home/pi/test.txt';
    exit 0;
fi;

echo 'ko 1 restart vpn' >> '/home/pi/test.txt';

sudo systemctl restart openvpn@client;
sudo service networking restart;
sleep 60;


if "${PING_CMD[@]}";
then
    echo 'ok 2' >> '/home/pi/test.txt';
    exit 0;
fi;

echo 'ko 2 reboot' >> '/home/pi/test.txt';
sudo reboot;
