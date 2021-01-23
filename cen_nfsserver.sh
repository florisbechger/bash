#!/bin/bash
#
sudo mkdir /data
sudo mkdir /data/nfs
sudo chmod 0555 /data
sudo chmod -R 0755 /data/nfs
sudo firewall-cmd --add-service=nfs
sudo firewall-cmd --add-source=10.0.2.0/24
sudo firewall-cmd --runtime-to-permanent
sudo firewall-cmd --reload
sudo systemctl restart firewalld
sudo firewall-cmd --list-all
sudo dnf install nfs-utils -y
sudo systemctl start nfs-server rpcbind
sudo systemctl enable --now nfs-server rpcbind
sudo echo '10.0.2.95 nfs-server' >> /etc/hosts
# sudo mount -t nfs -o nfsvers=4 nfs-server:/data/nfs /data/nfsshare
sudo echo 'nfs-server:/data/nfs  /data/nfsshare   nfs defaults   0 0' >> /etc/fstab # Make persistent
sudo echo '/data/nfs 10.0.2.0/24(rw,sync,no_root_squash)' >> /etc/exports
sudo systemctl restart nfs-server rpcbind
sudo exportfs -rav # export directories without restarting the NFS service

# More examples:
# echo '/data/nfs master(rw,sync,no_root_squash)' >> /etc/exports
# echo '/data/nfs index01(rw,sync,no_root_squash)' >> /etc/exports
# echo '/data/nfs index02(rw,sync,no_root_squash)' >> /etc/exports
# echo '/data/nfs search(rw,sync,no_root_squash)' >> /etc/exports
# echo '/data/nfs file01(rw,sync,no_root_squash)' >> /etc/exports
# echo '/data/nfs file02(rw,sync,no_root_squash)' >> /etc/exports
# nano /etc/exports #check /etc/exports
# also read: https://linuxize.com/post/how-to-use-sshfs-to-mount-remote-directories-over-ssh/
