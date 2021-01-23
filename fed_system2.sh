
# Hardening

# As root:
su

# Journal configuration:
sudo cp /etc/systemd/journald.conf journal.bak
cd /etc/systemd/
sudo sed -i 's/#SystemMaxUse=/SystemMaxUse=100M/g' /etc/systemd/journald.conf
sudo sed -i 's/#SystemMaxFileSize=/SystemMaxFileSize=100M/g' /etc/systemd/journald.conf
sudo sed -i 's/#SystemMaxFiles=/SystemMaxFiles=/g' /etc/systemd/journald.conf

# Firewall configuration:
sudo firewall-cmd --zone=public --remove-service=ssh --permanent
sudo firewall-cmd --zone=public --remove-service=dhcpv6-client --permanent
sudo firewall-cmd --set-default-zone FedoraWorkstation
sudo firewall-cmd --zone=FedoraWorkstation --remove-service=dhcpv6-client --permanent
sudo firewall-cmd --zone=FedoraWorkstation --add-service=dhcp --permanent
sudo firewall-cmd --zone=FedoraWorkstation --add-service=dns --permanent
sudo firewall-cmd --zone=FedoraWorkstation --add-service=ipp --permanent
sudo firewall-cmd --zone=FedoraWorkstation --add-service=ipp-client --permanent
sudo firewall-cmd --zone=FedoraWorkstation --add-service=mdns --permanent
sudo firewall-cmd --zone=FedoraWorkstation --add-service=ntp --permanent
sudo firewall-cmd --zone=FedoraWorkstation --add-service=samba-client --permanent
sudo firewall-cmd --zone=FedoraWorkstation --add-service=ssh --permanent
sudo firewall-cmd --reload

# Disable IPv6:
sudo echo "# Prevent the kernel module from loading:" >> /etc/modprobe.conf
sudo echo "install ipv6 /bin/true" >> /etc/modprobe.conf

sudo echo "# Disable ipv6:" >> /etc/sysconfig/network
sudo echo "NETWORKING_IPV6=no" >> /etc/sysconfig/network
sudo echo "IPV6INIT=no" >> /etc/sysconfig/network

# ClamAV installation:
sudo dnf install clamav-update -y
sudo freshclam
sudo clamscan --infected --remove --recursive /home/

# Documentation:
now=$(date +"%Y%m%d")
sudo dmesg | grep 'microcode' > Documents/microcode-$now.txt
sudo hostnamectl > Documents/hostname-$now.txt
sudo timedatectl > Documents/time-$now.txt
sudo df -h > Documents/filesystem-$now.txt
sudo firewall-cmd --state > Documents/firewall_$now.txt
sudo firewall-cmd --list-all >> Documents/firewall_$now.txt
sudo systemd-analyze > Documents/startup-$now.txt
sudo systemctl --failed > Documents/failed-services-$now.txt
sudo dnf repolist -v > Documents/repolist-$now.txt
sudo dnf history userinstalled > Documents/userinstalled-$now.txt
