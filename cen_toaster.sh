
#!/bin/bash

# https://www.yoctoproject.org/docs/3.1.1/toaster-manual/toaster-manual.html
# https://linuxhint.com/centos8_package_management_dnf

# Basic requirements for CentOS 8:
# sudo dnf clean all -y # clean the DNF package repositorycaches
# sudo dnf makecache -y # update the DNF package repository cache
# sudo dnf upgrade-minimal -y # only install absolutely required security patches
# sudo dnf autoremove -y # remove unnecessary packages if available

# sudo dnf upgrade # full system update
# Check all enabled repositories
# sudo dnf repolist # list all available repositories on your system
# sudo dnf repolist --enabled # list all enabled repositories on your system
# sudo dnf repolist --disabled # list all disabled repositories on your system
# sudo dnf repolist --all # list all available repositories available (a very very long list!)
# sudo dnf search "Virtual Machines" # Search for available packages
# sudo dnf repoquery *kvm* # Search for a specific package
# sudo dnf list --installed # list all installed packages on your system

# create user toaster:
sudo /usr/sbin/useradd -g users -G toaster -s /bin/false # add group wheel?

# firewall config:
sudo firewall-cmd --permanent --zone=public --add-port=8000/tcp
sudo firewall-cmd --reload
sudo systemctl reload firewalld

# install repo:
sudo dnf install epel-release -y
sudo dnf config-manager --set-enabled PowerTools # PowerTools repo provides additional packages such as rpcgen and texinfo
sudo dnf makecache # makecache command consumes additional Metadata from epel-release

# install basic packages:

sudo dnf install bzip2 chrpath diffstat gcc gcc-c++ git make patch python3 python3-pip rpcgen tar -y

# clone poky:
sudo git clone git://git.yoctoproject.org/poky --progress # clone poky

# install Toaster:
sudo pip3 install --user -r /home/vagrant/poky/bitbake/toaster-requirements.txt
# pip3 install --user -r /root/poky/bitbake/toaster-requirements.txt
# pip3 list installed --format=columns

# start Toaster:
sudo source /home/vagrant/poky/oe-init-build-env
# source /root/poky/oe-init-build-env
sudo source toaster start webport=192.168.0.90:8000
