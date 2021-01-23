
# Fedora minimal-install + standard

# As root:
su

# NIC configuration:
sudo nmcli connection modify 'enp0s31f6' connection.autoconnect yes

# DNF configuration:
sudo cp /etc/dnf/dnf.conf dnf.bak
sudo echo "fastestmirror=True" >> /etc/dnf/dnf.conf
sudo echo "deltarpm=True" >> /etc/dnf/dnf.conf

# Chrony configuration:
sudo cp /etc/chrony.conf chrony.bak
sudo sed -i 's/driftfile/#driftfile/g' /etc/chrony.conf
sudo sed -i 's/local stratum 10/local stratum 8/g' /etc/chrony.conf
sudo systemctl restart chronyd
sudo chronyc makestep
sudo chronyc sources
sudo chronyc -N authdata

# Initial installs:
sudo dnf distro-sync -y
sudo dnf group install hardware-support -y

# Default splash screen:
sudo plymouth-set-default-theme --list # list themes
sudo plymouth-set-default-theme # current theme
sudo dnf install plymouth-theme-spinfinity -y
sudo plymouth-set-default-theme spinfinity -R

# As user:
su [user]

# Gnome installation:
# sudo dnf group list # List all groupinstalls
# sudo dnf group list hidden -v # List hidden groupinstalls
# sudo dnf group list hidden -v | grep -i gnome | more
# dnf group list | grep -i gnome
sudo dnf group install critical-path-gnome -y
sudo dnf install constantine-backgrounds verne-backgrounds-gnome -y
# sudo dnf install gnome-shell-extension-apps-menu -y                       

# Gnome directories:
sudo dnf install xdg-user-dirs -y
sudo xdg-user-dirs-update

# Gnome at startup:
sudo systemctl list-units --type target --all | grep graphical.target # check GUI mode
sudo systemctl set-default graphical.target # enable graphical desktop environment at boot
# sudo systemctl get-default # check graphical desktop environment
sudo systemctl isolate graphical.target # switch to GUI mode

# DNF cleanup:
sudo dnf clean dbcache -y
sudo dnf clean packages -y
sudo dnf clean metadata -y
sudo dnf clean all -y

# Printer:
sudo dnf install cups simple-scan system-config-printer -y
sudo systemctl start cups
sudo systemctl status cups
sudo systemctl enable cups
# sudo cupsctl --remote-admin --remote-any --share-printers --user-cancel-any

# Main packages:
sudo dnf install baobab clamav clamav-update eog firewall-config gnome-disk-utility gnome-screenshot gnome-system-monitor gnome-tweak-tool gparted htop lshw neofetch NetworkManager-tui powerline powerline-fonts powertop ranger simple-scan switchdesk switchdesk-gui timeshift -y

# Bashrc additions:
sudo echo "alias ls='ls -hF --color=auto'" >> ~/.bashrc
sudo echo "alias la='ls -ahF --color=auto'" >> ~/.bashrc
sudo echo "# make the dir command work kinda like in windows (long format)" >> ~/.bashrc
sudo echo "alias dir='ls --color=auto --format=long'" >> ~/.bashrc
sudo echo "# make grep highlight results using color" >> ~/.bashrc
sudo echo "alias grep='grep --color=auto'" >> ~/.bashrc
sudo echo "" >> ~/.bashrc
sudo echo "# Neofetch" >> ~/.bashrc
sudo echo "" >> ~/.bashrc
sudo echo "neofetch" >> ~/.bashrc

# MS-Fonts installation for Office suite:
sudo dnf install curl cabextract xorg-x11-font-utils fontconfig -y
sudo rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
sudo fc-cache -v

# Flatpak packages:
sudo flatpak install fedora audacious cheese firefox geany libreoffice mediawriter -y
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak remotes
sudo flatpak install flathub filezilla teams zoom -y

exit
