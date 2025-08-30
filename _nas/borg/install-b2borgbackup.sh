#!/usr/bin/env bash
set -e

sudo apt-get install -y borgbackup rclone

groups=(vault private)
if ! id -u b2borgbackup >/dev/null 2>&1; then
    sudo useradd -m -s /bin/bash b2borgbackup
    echo "Created user b2borgbackup."
else
    echo "User b2borgbackup already exists."
fi
for g in "${groups[@]}"; do
    sudo usermod -aG "$g" b2borgbackup
    echo "Added b2borgbackup to group $g."
done

echo "Installing backup and sync scripts"
sudo mkdir -p /home/b2borgbackup/borg
sudo cp b2-borg-create-backup.sh b2-borg-sync-backups.sh b2-borg-backup-and-sync.sh /home/b2borgbackup/borg/
sudo chown -R b2borgbackup:vault /home/b2borgbackup/borg
sudo chmod 750 /home/b2borgbackup/borg/*.sh

if [ ! -f /home/b2borgbackup/.secrets ]; then
    sudo touch /home/b2borgbackup/.secrets
    sudo chown b2borgbackup:vault /home/b2borgbackup/.secrets
    sudo chmod 640 /home/b2borgbackup/.secrets
    echo "Created empty /home/b2borgbackup/.secrets file."
else
    echo "/home/b2borgbackup/.secrets already exists."
fi

echo "Installing systemd service and timer"
sudo cp b2-borg-backup-and-sync.service b2-borg-backup-and-sync.timer /etc/systemd/system/

echo "Enabling and starting systemd timer"
sudo systemctl daemon-reload
sudo systemctl enable --now b2-borg-backup-and-sync.timer

echo "Backup and sync automation installed and enabled for user b2borgbackup."

