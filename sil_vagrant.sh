
# install qemu-kvm:
sudo rpm-ostree install qemu-kvm libvirt libguestfs-tools virt-install

# enable and start the libvirt daemon:
sudo systemctl enable --now libvirtd

# install Vagrant:

sudo rpm-ostree install vagrant

# install the Vagrant libvirtd plugin:
sudo vagrant plugin install vagrant-libvirt


