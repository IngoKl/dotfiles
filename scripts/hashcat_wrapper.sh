#!/bin/sh

method=$1
hash=$2
wl=/usr/share/wordlists/rockyou.txt

if [ -z "$method" ]; then
  echo "Usage: ./hashcat_wrapper.sh sha1 A94A8FE5CCB19BA61C4C0873D391E987982FBBD3"
  echo "Supported: md5, sha1, ntlm"
  exit
fi

case $method in

  md5)
    hashcat -a 0 -m 2600 $hash $wl
    ;;

  sha1)
    hashcat -a 0 -m 100 $hash $wl
    ;;

  ntlm)
    hashcat -a 0 -m 1000 $hash $wl
    ;;

  *)
    echo -n "Method not found"
    ;;
esac