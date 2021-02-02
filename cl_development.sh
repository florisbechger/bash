
# Packages for ClearLinux

sudo swupd check-update
sudo swupd search virt
sudo swupd bundle-add virt-manager-gui
sudo swupd bundle-add ansible
sudo swupd bundle-add containers-virt
sudo swupd bundle-add audacious
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

