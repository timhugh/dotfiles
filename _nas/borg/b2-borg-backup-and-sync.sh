#!/usr/bin/env bash

# set secrets, passphrase, etc.
source "${HOME}/.secrets"

backup_script="$(dirname "$0")/b2-borg-create-backup.sh"
sync_script="$(dirname "$0")/b2-borg-sync-backups.sh"

# Run backup
if "$backup_script"; then
  echo "$(date) - Backup completed successfully, proceeding to sync..."
  "$sync_script"
  exit $?
else
  echo "$(date) - Backup FAILED, skipping sync" >&2
  exit 1
fi

