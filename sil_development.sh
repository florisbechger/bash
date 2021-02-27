
# Fedora Silverblue 33 - Development

# check toolbox, create and enter your first container:
toolbox
toolbox list
toolbox create -c Test -y # Create Test
# toolbox enter -c Test
toolbox rm -f Test -y # Remove Test
# toolbox rm --force Test

# install flatpak packages:
sudo flatpak install fedora geany libreoffice -y
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak remotes
sudo flatpak install flathub audacious filezilla mediawriter teams zoom -y

# install flatpak updates:
# sudo flatpak remotes
# sudo flatpak update

# install cockpit package:
sudo rpm-ostree install cockpit-ostree cockpit cockpit-machines cockpit-podman cockpit-selinux virt-viewer
# sudo rpm-ostree install cockpit-storaged PackageKit

# install qemu-kvm:
sudo rpm-ostree install qemu-kvm libvirt libguestfs-tools virt-install virt-manager # rsync allready installed
sudo systemctl enable libvirtd
sudo systemctl start libvirtd
sudo systemctl status libvirtd # verify install

# install vagrant:
sudo rpm-ostree install vagrant

# install the vagrant libvirtd plugin:
vagrant plugin install vagrant-libvirt
vagrant plugin install vagrant-disksize
vagrant plugin list # verify plugin install

vagrant status # verify vagrant install
