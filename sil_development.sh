
# Fedora Silverblue 33 Development

# install qemu-kvm:
sudo rpm-ostree install qemu-kvm libvirt libguestfs-tools virt-install rsync
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
