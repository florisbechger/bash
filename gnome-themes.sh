
# Themes for Gnome
# https://www.gnome-look.org

# For this example:

# Juno-mirage theme: https://www.pling.com/s/Gnome/p/1280977/
# Flatery-Dark icons: https://www.pling.com/p/1332404/

# Download Juno-mirage theme
ls -la ~/Downloads/ # list files
tar -xvf Juno-mirage.tar.xz
sudo mv ~/Downloads/Juno-mirage/ /usr/share/themes/
cd /usr/share/themes/
sudo chown root:root Juno-mirage -R
sudo gsettings set org.gnome.desktop.interface gtk-theme Juno-mirage

# Download Flatery-Dark icons
ls -la ~/Downloads/ # list files
tar -xvf Flatery-Dark.tar.xz
sudo mv Flatery-Dark/ /usr/share/icons/
cd /usr/share/icons/
sudo chown root:root Flatery-Dark -R
sudo gsettings set org.gnome.desktop.interface icon-theme Flatery-Dark
