#!/usr/bin/env bash

export TMPDIR=/mnt/vault/tmp

vault=name-of-b2-vault

echo "$(date) - syncing updates to b2"
rclone sync /mnt/vault/backups b2:$vault --transfers=1 --verbose
echo "$(date) - done"

# this step deletes any partial files from failed syncs
echo "$(date) - cleaning up b2"
rclone cleanup b2:$vault --verbose

