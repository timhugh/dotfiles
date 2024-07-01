#!/bin/sh

set -e

user=$1
password=$2
groups=$3

if [ -z "$user" ] || [ -z "$password" ] || [ -z "$groups" ]; then
  echo "Usage: $0 <username> <password> <group1>,<group2>,..."
  exit 1
fi

adduser -H -D -s /sbin/nologin -G users $user
(echo $password; echo $password) | smbpasswd -a $user
for group in $(echo $groups | tr ',' ' '); do
  adduser $user $group
done

