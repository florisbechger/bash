
# Themes for Gnome
# https://www.gnome-look.org

# Download [theme]
ls -la ~/Downloads/ # list files
tar -xvf [theme].tar.xz
sudo mv ~/Downloads/[theme]/ /usr/share/themes/
cd /usr/share/themes/
sudo chown root:root [theme] -R
sudo gsettings set org.gnome.desktop.interface gtk-theme [theme]
sudo gsettings reset org.gnome.desktop.interface

# Download [icons]
ls -la ~/Downloads/ # list files
tar -xvf [icons].tar.xz
sudo mv [icons]/ /usr/share/icons/
cd /usr/share/icons/
sudo chown root:root [icons] -R
sudo gsettings set org.gnome.desktop.interface icon-theme [icons]
