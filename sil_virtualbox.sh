
# VirtualBox on Fedora Silverblue 34 (NOTE: no repo needed):

# install virtualBox

sudo wget https://download.virtualbox.org/virtualbox/rpm/fedora/34/x86_64/VirtualBox-6.1-6.1.22_144080_fedora33-1.x86_64.rpm
sudo rpm-ostree install ./VirtualBox-*.rpm

# reboot:

systemctl reboot
