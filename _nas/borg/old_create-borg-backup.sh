#!/usr/bin/env bash

# secrets just contained the BORG_PASSPHRASE
source ~/.secrets

archive_name="vault-$(date +%Y%m%dT%H%M%S)"
echo "$(date) creating backup ${archive_name}"

borg_options="--stats --compression zstd,22"

borg create ${borg_options} /mnt/vault/backups::${archive_name} /mnt/vault/shared
echo "$(date) backup complete"

