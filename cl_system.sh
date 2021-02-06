
# REF: https://docs.01.org/clearlinux/latest/get-started/index.html

# Enable thermal management daemon to prevent overheating:
sudo systemctl enable --now thermald

# Enable systemd-boot Menu:
sudo clr-boot-manager set-timeout 5

# Time/Date settings:
sudo timedatectl set-timezone Europe/Amsterdam
sudo timedatectl set-ntp true
sudo systemctl restart systemd-timesyncd
sudo hwclock --systohc
# sudo timedatectl timesync-status

# System Bundles for ClearLinux:
sudo swupd check-update
sudo swupd update

sudo swupd bundle-add firewalld
sudo systemctl mask iptables-restore ipset # Disable iptables and ipset services as they conflict with firewalld
sudo mkdir /etc/firewalld
sudo touch /etc/firewalld/firewalld.conf
sudo systemctl enable firewalld
sudo systemctl start firewalld

sudo swupd bundle-add clr-network-troubleshooter # network tools e.g. ping, nmtui, etc.
sudo swupd bundle-add audacious # audio player
sudo swupd diagnose
sudo swupd clean

# LibreOffice:
sudo swupd bundle-add libreoffice


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
