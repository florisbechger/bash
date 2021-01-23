#!/bin/bash
#
sudo mkdir /data
sudo mkdir /data/nfsshare
sudo chmod 0555 /data
sudo chmod -R 0755 /data/nfsshare
sudo firewall-cmd --add-service=nfs
sudo firewall-cmd --add-source=10.0.2.0/24
sudo firewall-cmd --runtime-to-permanent
sudo firewall-cmd --reload
sudo systemctl restart firewalld
sudo firewall-cmd --list-all
sudo dnf install nfs-utils -y
sudo systemctl restart nfs-server rpcbind
sudo echo '10.0.2.95 nfs-server' >> /etc/hosts
sudo mount -t nfs -o nfsvers=4 nfs-server:/data/nfs  /data/nfsshare
sudo echo 'nfs-server:/data/nfs  /data/nfsshare   nfs defaults   0 0' >> /etc/fstab # Make persistent
sudo systemctl restart nfs-server rpcbind
