#!/bin/bash

id_rsa=$1

echo $id_rsa

if [ ! -f $id_rsa ]; then
    echo "Cracking $1 using John"

    python /usr/share/john/ssh2john.py $id_rsa > id_rsa.hash
    john --wordlist=/usr/share/wordlists/rockyou.txt id_rsa.hash
else
    echo "./crack_id_rsa.sh /home/kali/.ssh/id_rsa"
fi
