# https://www.digitalocean.com/community/tutorials/how-to-create-raid-arrays-with-mdadm-on-debian-9#creating-a-raid-5-array

# TODO: spin down disks when not in use

sudo apt install mdadm

# prep disks using fdisk
sudo fdisk /dev/sdX
# I ended up with this:
NAME        MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
sda           8:0    0   2.7T  0 disk
└─sda1        8:1    0   2.7T  0 part
sdb           8:16   0   2.7T  0 disk
└─sdb1        8:17   0   2.7T  0 part
sdc           8:32   0   2.7T  0 disk
└─sdc1        8:33   0   2.7T  0 part
sdd           8:48   0   2.7T  0 disk
└─sdd1        8:49   0   2.7T  0 part

# create raid array from partitions
sudo mdadm --create --verbose /dev/md0 --level=5 --raid-devices=4 /dev/sda1 /dev/sdb1 /dev/sdc1 /dev/sdd1

# to check status:
cat /proc/mdstat

# format the file system and mount it
sudo apt-get install xfsprogs
sudo mkfs.xfs -f /dev/md0
sudo mkdir -p /mnt/vault
sudo mount /dev/md0 /mnt/vault

# set up permissions
sudo useradd -M -s /sbin/nologin vault
sudo useradd -M -s /sbin/nologin -G vault private

# after copying all of the data over
sudo chown -R vault:vault /mnt/vault
sudo chown -R private:private /mnt/vault/private
# NB: this will wipe the x flag on everything that isn't a directory, but that's fine for my use case
find /mnt/vault -type d -exec chmod 0770 {} +
find /mnt/vault -type f -exec chmod 0660 {} +

# configure array to mount on boot
sudo mdadm --detail --scan | sudo tee -a /etc/mdadm/mdadm.conf
sudo update-initramfs -u
echo '/dev/md0 /mnt/vault xfs defaults,noatime,nouser 0 0' | sudo tee -a /etc/fstab

