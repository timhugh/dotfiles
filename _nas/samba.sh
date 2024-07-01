# run samba in docker

docker-compose up -d samba

# add users
docker-compose exec -it samba add-smb-user.sh name password group1,group2

