# https://www.digitalocean.com/community/tutorials/how-to-set-up-a-firewall-with-ufw-on-debian

sudo apt install ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw enable

