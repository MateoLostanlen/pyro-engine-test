#!/bin/bash


set -u
echo $(date +"%H:%M:%S") >> '/home/pi/git.txt';

git fetch origin master;

PING_CMD=('git' 'diff' 'origin/master')

if "${PING_CMD[@]}";
then
    echo 'ok' >> '/home/pi/git.txt';
fi;

echo 'ko' >> '/home/pi/git.txt';
