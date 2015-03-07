#!/bin/bash

echo -n "Username: "
read username

echo "SSH-Key: "
read key

useradd -m -s /bin/bash $username

# TODO: secure things - do not allow portforwardings etc. 

mkdir /home/$username/.ssh
chmod 700 /home/$username/.ssh
echo "command=\"screen -x screen/shared\" $key" >> /home/$username/.ssh/authorized_keys
chown -R ${username}:${username} /home/$username/.ssh/

echo "acladd $username" >>/home/screen/.screenrc
