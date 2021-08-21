#!/bin/bash

echo "This script will disturb all other PTSs"
read -p "Continue? [y/n] " -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
  exit
fi

current_pts=$(tty | cut -c 6-)
ptss=$(ps aux | grep pts | awk '{print $7}')

while [ True ]; do
  for pts in $ptss
  do
    if [ ! $current_pts = $pts ]; then
      echo "Writing /dev/urandom to pts $pts"
      head -5 /dev/urandom > /dev/$pts
    fi
  done
done
