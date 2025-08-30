# to spin down disks when there's no activity
# NB: this can usually be done with hdparm but not with my WD Red disks!

sudo apt-get install hd-idle

# create a systemd service to run it
sudo cp ./hd-idle.service /etc/systemd/system/hd-idle.service
sudo systemctl enable hd-idle
sudo systemctl start hd-idle

