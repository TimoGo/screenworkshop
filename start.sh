#!/bin/bash

# first: the hostkeys to avoid man-in-the-middle attack warnings
sshdir="/root/dockerbuild/screenws/ssh/"

if [ ! -f ${sshdir}ssh_host_rsa_key  ]; then
 echo "you have to generate ssh hostkeys first:"
 echo "ssh-keygen -q -N \"\" -t dsa -f ${sshdir}ssh_host_dsa_key"
 echo "ssh-keygen -q -N \"\" -t rsa -f ${sshdir}ssh_host_rsa_key"
 echo "ssh-keygen -q -N \"\" -t ecdsa -f ${sshdir}ssh_host_ecdsa_key"
 exit 1
fi

docker run -h screenws -v ${sshdir}ssh_host_dsa_key:/etc/ssh/ssh_host_dsa_key  \
                       -v ${sshdir}ssh_host_dsa_key.pub:/etc/ssh/ssh_host_dsa_key.pub  \
                       -v ${sshdir}ssh_host_rsa_key:/etc/ssh/ssh_host_rsa_key  \
                       -v ${sshdir}ssh_host_rsa_key.pub:/etc/ssh/ssh_host_rsa_key  \
                       -v ${sshdir}ssh_host_ecdsa_key:/etc/ssh/ssh_host_ecdsa_key  \
                       -v ${sshdir}ssh_host_ecdsa_key.pub:/etc/ssh/ssh_host_ecdsa_key.pub  \
-p 192.168.5.65:3333:22 -p 127.0.0.1:3333:22 -d --name screenws screenws 
