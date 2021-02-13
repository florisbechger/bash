
sudo apt-get update
sudo dnf install gnome-power-manager htop lshw neofetch thermald -y
sudo apt-get install gnome-power-manager htop lshw neofetch thermald -y
sudo systemctl enable thermald
sudo systemctl start thermald

# Configure SSD trim:
sudo systemctl enable fstrim.timer
sudo systemctl start fstrim.timer

# WiFi + Bluetooth utilities:
sudo pkexec dmesg | grep -i wifi
sudo pkexec dmesg | grep -i bluetooth

# Battery management:
sudo apt-get install tlp -y
sudo systemctl enable tlp
sudo systemctl start tlp

# Firewall:
sudo dnf install firewalld firewall-config firewall-applet -y
sudo apt-get install firewalld firewall-config firewall-applet -y

# Antivirus:
sudo dnf install clamav clamtk -y
sudo apt-get install clamav clamtk -y

# Sensors:
sudo dnf install ibam lm-sensors -y
sudo apt-get install ibam lm-sensors -y
sudo sensors-detect
# sudo nano /etc/sensors3.conf

sudo echo "" >> ~/.bashrc
sudo echo "# Custom:" >> ~/.bashrc
sudo echo "echo" >> ~/.bashrc
sudo echo "neofetch" >> ~/.bashrc
sudo echo "ibam" >> ~/.bashrc
sudo echo "echo" >> ~/.bashrc
