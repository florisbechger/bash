
# Install Flatpak:
sudo apt-get install flatpak flatpak-session-helper -y
sudo apt-get install gnome-software-plugin-flatpak -y
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak remotes # Flatpak synchronize

# Install VirtualBox:
cd ~/Downloads
su # Change to root
sudo echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian buster contrib" >> /etc/apt/sources.list.d/various.list
exit
wget https://www.virtualbox.org/download/oracle_vbox_2016.asc
sudo apt-key add oracle_vbox_2016.asc
sudo apt update
sudo apt-get install curl -y
curl -O https://www.virtualbox.org/wiki/Downloads/virtualbox-6.1_6.1.16-140961~Debian~buster_amd64.deb
sudo apt update
sudo apt-get install virtualbox-6.1 -y
mkdir ~/Documents/Virtualbox

# Install Vagrant:
cd ~/Downloads
curl -O https://releases.hashicorp.com/vagrant/2.2.14/vagrant_2.2.14_x86_64.deb
sudo apt update
sudo apt-get install ./vagrant_2.2.14_x86_64.deb -y
vagrant --version
mkdir ~/Documents/Vagrant
exit
