#!/bin/bash
#
# journalctl -xb # For logbooks
#
# Enable SELinux:
# SELINUX=disabled
# dnf install selinux-policy -y # allready installed
# getenforce
# setenforce 0 # permissive
# setenforce 1 # make active
#
# Network settings:
hostnamectl set-hostname ansible --static
nmcli con mod enp0s3 ipv4.address 10.0.2.95/24
nmcli con mod enp0s3 ipv4.gateway 10.0.2.1
nmcli con mod enp0s3 ipv4.dns "208.67.220.220 208.67.222.222"
nmcli con mod enp0s3 ipv4.method manual
nmcli con mod enp0s3 connection.autoconnect yes
nmcli con mod enp0s8 ipv4.address 192.168.178.95/24
nmcli con mod enp0s8 ipv4.gateway 192.168.178.1
nmcli con mod enp0s8 ipv4.dns "192.168.178.1 89.101.251.228 89.101.251.229"
nmcli con mod enp0s8 ipv4.method manual
nmcli con mod enp0s8 connection.autoconnect yes
systemctl restart systemd-hostnamed
systemctl restart NetworkManager
#
# nmcli connection down enp0s3
# nmcli connection up enp0s3
# nmcli dev status
# nano /etc/sysconfig/network-scripts/ifcfg-enp0s3
# nmcli con mod enp0s3 ipv4.dns "192.168.178.1 208.67.220.220 208.67.222.222" # OpenDNS
# nmcli con mod enp0s3 ipv4.dns "192.168.178.1 89.101.251.228 89.101.251.229" # Ziggo
# nmcli con mod enp0s3 ipv4.dns "194.109.6.66 194.109.9.99 194.109.104.104" # xs4all
#
# Installing the Control Node:
dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y # To enable EPEL Repo for RHEL/CentOS 8
dnf config-manager --set-enabled PowerTools -y
dnf install --enablerepo epel-playground ansible -y # install ansible
ansible --version # check version
dnf install nano -y
#
cp /etc/ansible/hosts /etc/ansible/hosts.bak
echo "" > /etc/ansible/hosts
echo "[ansible]" >> /etc/ansible/hosts
echo "10.0.2.95 ansible_user=root" >> /etc/ansible/hosts # ansible
echo "" >> /etc/ansible/hosts
echo "[master]" >> /etc/ansible/hosts
echo "10.0.2.100 ansible_user=root" >> /etc/ansible/hosts # Splunk master
echo "" >> /etc/ansible/hosts
echo "[index]" >> /etc/ansible/hosts
echo "10.0.2.101 ansible_user=root" >> /etc/ansible/hosts # Splunk index01
echo "10.0.2.102 ansible_user=root" >> /etc/ansible/hosts # Splunk index02
echo "" >> /etc/ansible/hosts
echo "[search]" >> /etc/ansible/hosts
echo "10.0.2.105 ansible_user=root" >> /etc/ansible/hosts # Splunk search
echo "" >> /etc/ansible/hosts
echo "[forwarder]" >> /etc/ansible/hosts
echo "10.0.2.110 ansible_user=root" >> /etc/ansible/hosts # Server file01
echo "10.0.2.120 ansible_user=root" >> /etc/ansible/hosts # Server file02
#
# https://www.server-world.info/en/note?os=CentOS_8&p=ssh&f=4
# Read about generating keys:
ssh-keygen # generate key
#
ssh-copy-id 10.0.2.100 # copy key to instance
ssh-copy-id 10.0.2.101 # copy key to instance
ssh-copy-id 10.0.2.102 # copy key to instance
ssh-copy-id 10.0.2.105 # copy key to instance
ssh-copy-id 10.0.2.110 # copy key to instance
ssh-copy-id 10.0.2.120 # copy key to instance
#
exec ssh-agent $SHELL
ssh-add
ssh-add -l
ssh root@10.0.2.100 # try login
systemctl reload sshd.service
#
ansible all --list-hosts
ansible all -a "uname -a"
ansible all -m ping
#
# https://www.digitalocean.com/community/cheatsheets/how-to-use-ansible-cheat-sheet-guide
#
# ansible all -m ping -i /etc/ansible/hosts
# ansible all -m ping -u root
# ansible all -m ping --ask-pass
# ansible 10.0.2.100 -m dnf -a "name=nano" --check
# ansible-playbook test.yml --check
# ansible-playbook test.yml --ask-pass
# ansible-playbook test.yml --list-tasks
# ansible-playbook test.yml --list-hosts
# ansible-playbook test.yml --list-tags
