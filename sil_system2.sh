
# Fedora Silverblue 34 - Install 2

# install updates:
sudo rpm-ostree refresh-md
# sudo rpm-ostree update
sudo rpm-ostree upgrade distro-sync

# uninstall Chinese, Japanese and Korean input add-ons (testing):
sudo rpm-ostree override remove ibus-hangul
sudo rpm-ostree override remove ibus-libzhuyin
sudo rpm-ostree override remove ibus-libpinyin
# sudo rpm-ostree override remove ibus-kkc
# sudo rpm-ostree override remove ibus-anthy

# check running version:
sudo rpm-ostree status

# enable RPM-Fusion:
# sudo rpm-ostree install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
# sudo rpm-ostree install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-34.noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-33.noarch.rpm

# update to version 35:
# ostree remote list
# sudo ostree remote gpg-import fedora -k /etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-33-primary
# sudo rpm-ostree rebase fedora:fedora/35/x86_64/silverblue

# install extra packages:
sudo rpm-ostree install NetworkManager-tui clamav clamtk constantine-backgrounds firewall-config gnome-tweak-tool gparted htop neofetch simple-scan system-config-printer tlp verne-backgrounds-gnome

# create shortcuts:
# SUPER - B Browser (Firefox)
# SUPER - H Files (Home)
# SUPER - T Terminal (gnome-terminal)

# reboot:
sudo systemctl reboot

# END
