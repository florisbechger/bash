
# VirtualBox on Fedora Silverblue 33 (NOTE: update needed on VirtualBox!):

# install virtualbox repo:

cd /etc/yum.repos.d/
sudo wget https://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo

# edit virtualbox repo:

sudo nano /etc/yum.repos.d/virtualbox.repo

# change line and add line:

# baseurl=http://download.virtualbox.org/virtualbox/rpm/fedora/$releasever/$basearch
baseurl=https://download.virtualbox.org/virtualbox/rpm/fedora/32/$basearch

# remove python 3.9:

sudo rpm-ostree override remove python3.9

# install dependency packages:

sudo rpm-ostree install dkms gcc make python3.8

# reboot:

systemctl reboot

# install virtualbox

sudo rpm-ostree install VirtualBox-6.1

# sudo wget https://download.virtualbox.org/virtualbox/rpm/fedora/32/x86_64/VirtualBox-6.1-6.1.16_140961_fedora32-1.x86_64.rpm
# sudo rpm-ostree install ./VirtualBox-*.rpm
