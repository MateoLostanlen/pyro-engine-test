#!/bin/bash


set -u
echo $(date +"%H:%M:%S") >> '/home/pi/git.txt';
git -C /home/pi/pyro-engine-test reset --hard;
git -C /home/pi/pyro-engine-test fetch origin master;

PING_CMD=('git' '-C' '/home/pi/pyro-engine-test' 'diff' 'origin/master')

if "${PING_CMD[@]}";
then
    echo 'uptodate' >> '/home/pi/git.txt';
    exit 0;
fi;

echo 'updating from repo ...' >> '/home/pi/git.txt';
git -C /home/pi/pyro-engine-test merge origin/master;
