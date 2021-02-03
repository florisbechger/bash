
# Packages for ClearLinux

sudo swupd check-update
sudo swupd update

sudo swupd bundle-add audacious
sudo swupd bundle-add firewalld

sudo swupd bundle-add containers-basic
sudo swupd bundle-add docker-compose
sudo systemctl start docker

# sudo swupd search virt

sudo swupd diagnose

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
