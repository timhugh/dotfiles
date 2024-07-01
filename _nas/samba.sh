docker-compose up -d samba
docker-compose exec -it samba smbpasswd -a $USER

