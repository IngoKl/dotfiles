#!/bin/bash

echo "This script will disturb all other PTSs"
read -p "Continue? [y/n] " -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
  exit
fi

readarray -t own_pts <<< "$(ps aux | grep pts | grep $PPID | awk '{print $7}' | cut -f2 -d/)"
ptss=$(ps aux | grep pts | awk '{print $7}' | cut -f2 -d/)

current_pts=${own_pts[1]}

echo $current_pts

while [ True ]; do
  for pts in $ptss
  do
    if [ ! $current_pts = $pts ]; then
      echo "Writing /dev/urandom to pts $pts"
      head -5 /dev/urandom > /dev/pts/$pts
    fi
  done
done
