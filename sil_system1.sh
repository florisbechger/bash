
# Fedora Silverblue 34 - Install 1

# check status SE-Linux:
sudo setenforce Permissive
sudo sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config
sestatus -v 

# Set hostname:
sudo hostnamectl set-hostname [name][.local]

# Sync hardware clock:
sudo hwclock -w

# disable automatic updates:
sudo systemctl stop rpm-ostreed-automatic.service
sudo systemctl disable rpm-ostreed-automatic.service

# enable SSD trim:
# sudo systemctl start fstrim.timer
# sudo systemctl enable fstrim.timer

# DNF configuration:
su
sudo echo "fastestmirror=True" >> /etc/rpm-ostreed.conf
sudo echo "deltarpm=True" >> /etc/rpm-ostreed.conf

# Chrony configuration:
sudo sed -i 's/driftfile/#driftfile/g' /etc/chrony.conf
sudo sed -i 's/#local stratum 10/local stratum 8/g' /etc/chrony.conf
sudo systemctl restart chronyd
sudo chronyc makestep
sudo chronyc sources
sudo chronyc -N authdata

# Enable Wayland:
# sudo nano /etc/gdm/custom.conf

# Change default Wayland to Xorg:
# [deamon]
#WaylandEnable=false
#DefaultSession=gnome-xorg.desktop

# intel microcode:
# dmesg | grep microcode
# sudo rpm-ostree install iucode-tool # do not install!!

# update to version 35:
# ostree remote list
# sudo ostree remote gpg-import fedora -k /etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-35-primary
# sudo rpm-ostree rebase fedora:fedora/35/x86_64/silverblue

# Journal configuration:
sudo sed -i 's/#SystemMaxUse=/SystemMaxUse=100M/g' /etc/systemd/journald.conf
sudo sed -i 's/#SystemMaxFileSize=/SystemMaxFileSize=100M/g' /etc/systemd/journald.conf
sudo sed -i 's/#SystemMaxFiles=/SystemMaxFiles=/g' /etc/systemd/journald.conf

# Firewall configuration:
sudo firewall-cmd --zone=public --remove-service=ssh --permanent
sudo firewall-cmd --zone=public --remove-service=dhcpv6-client --permanent
sudo firewall-cmd --set-default-zone FedoraWorkstation
sudo firewall-cmd --zone=FedoraWorkstation --remove-service=dhcpv6-client --permanent

# END
