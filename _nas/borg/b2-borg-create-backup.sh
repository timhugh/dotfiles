#!/usr/bin/env bash

# set BORG_PASSPHRASE
source "${HOME}/.secrets"

archive_name="vault-$(date +%Y%m%dT%H%M%S)"
echo "$(date) - BORG: creating backup ${archive_name}"

borg_options="--stats --compression zstd,6 --progress"

borg create ${borg_options} /mnt/vault/backups::${archive_name} /mnt/vault/shared
echo "$(date) - BOR: backup created"

