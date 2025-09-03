#!/usr/bin/env bash

# set B2_BORG_VAULT_NAME
source "${HOME}/.secrets"

echo "$(date) - B2: syncing updates"
export RCLONE_FAST_LIST=1
rclone copy /mnt/vault/backups b2:$B2_BORG_VAULT_NAME --transfers=10 --verbose --progress
echo "$(date) - B2: sync complete"

# this step deletes any partial files from failed syncs
echo "$(date) - B2: cleaning up temp files"
rclone cleanup b2:$B2_BORG_VAULT_NAME --verbose

