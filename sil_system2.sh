
# Fedora Silverblue 33 - Install 2

# install updates:
sudo rpm-ostree refresh-md
sudo rpm-ostree update
sudo rpm-ostree upgrade distro-sync

# check running version:
sudo rpm-ostree status

# uninstall Chinese, Japanese and Korean input add-ons (testing):
sudo rpm-ostree override remove ibus-hangul
sudo rpm-ostree override remove ibus-libzhuyin
sudo rpm-ostree override remove ibus-libpinyin
sudo rpm-ostree override remove ibus-kkc

# enable RPM-Fusion:
# sudo rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo rpm-ostree install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-33.noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-33.noarch.rpm

# update to version 33:
# ostree remote list
# sudo ostree remote gpg-import fedora -k /etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-33-primary
# sudo rpm-ostree rebase fedora:fedora/33/x86_64/silverblue

# install extra packages:
sudo rpm-ostree install constantine-backgrounds verne-backgrounds-gnome firewall-config gnome-tweak-tool gparted htop NetworkManager-tui neofetch tlp # thermald allready installed

# create shortcuts:
# SUPER - B Browser (Firefox)
# SUPER - F Search
# SUPER - H Files (Home)
# SUPER - T Terminal (gnome-terminal)

# reboot:
sudo systemctl reboot

# END
