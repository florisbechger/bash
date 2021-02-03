
# Packages for ClearLinux

# Time/Date settings:
sudo touch /etc/systemd/timesyncd.conf
sudo echo "[Time]" >> /etc/systemd/timesyncd.conf
sudo echo "NTP=nts1.time.nl" >> /etc/systemd/timesyncd.conf
sudo echo "FallbackNTP=ntp1.time.nl" >> /etc/systemd/timesyncd.conf
sudo timedatectl set-ntp true
sudo systemctl restart systemd-timesyncd
sudo timedatectl timesync-status

sudo swupd check-update
sudo swupd update

sudo swupd bundle-add firewalld
sudo systemctl mask iptables-restore ipset # Disable iptables and ipset services as they conflict with firewalld
sudo mkdir /etc/firewalld
sudo touch /etc/firewalld/firewalld.conf
sudo systemctl enable firewalld
sudo systemctl start firewalld

sudo swupd bundle-add audacious
sudo swupd diagnose

# sudo swupd search virt

# Microsoft Office:
# Office365

# Microsoft Teams:
flatpak install flathub com.microsoft.Teams -y
# To run this Flatpak app, enter:
flatpak run com.microsoft.Teams

# Zoom:
flatpak install flathub us.zoom.Zoom -y
# To run this Flatpak app, enter:
flatpak run us.zoom.Zoom
