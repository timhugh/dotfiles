#!/usr/bin/env bash

# set B2_BORG_VAULT_NAME
source "${HOME}/.secrets"

export TMPDIR=/mnt/vault/tmp

echo "$(date) - B2: syncing updates"
rclone sync /mnt/vault/backups b2:$B2_BORG_VAULT_NAME --transfers=1 --verbose
echo "$(date) - B2: sync complete"

# this step deletes any partial files from failed syncs
echo "$(date) - B2: cleaning up temp files"
rclone cleanup b2:$vault --verbose

