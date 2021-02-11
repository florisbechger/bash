
# Install Flatpak:
sudo apt-get install flatpak -y
sudo apt-get install gnome-software-plugin-flatpak -y
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak remotes
sudo flatpak install filezilla geany teams zoom -y

# Install MSCore fonts:
sudo apt-get install msttcorefonts

# Install VirtualBox:
cd ~/Downloads
su # Change to root
sudo echo "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian buster contrib" >> /etc/apt/sources.list.d/various.list
exit
wget https://www.virtualbox.org/download/oracle_vbox_2016.asc
sudo apt-key add oracle_vbox_2016.asc
sudo apt update
sudo apt-get install curl -y
curl -O https://www.virtualbox.org/wiki/Downloads/virtualbox-6.1_6.1.18-142142~Debian~buster_amd64.deb
sudo apt update
sudo apt-get install virtualbox-6.1 -y
mkdir ~/Documents/Virtualbox

# Create a VM in VirtualBox (e.g. "debian")

# Install Vagrant:
cd ~/Downloads
curl -O https://releases.hashicorp.com/vagrant/2.2.14/vagrant_2.2.14_x86_64.deb
sudo apt update
sudo apt-get install ./vagrant_2.2.14_x86_64.deb -y
exit

# Blacklist intel_kvm in order for VirtualBox to run correctly:
lsmod | grep kvm # list services
su # Change to root
echo 'blacklist kvm-intel' >> /etc/modprobe.d/blacklist.conf
exit
sudo reboot
