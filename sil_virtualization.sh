
# Fedora Silverblue 34 - KVM Virtualization

# Virtualization:

sudo rpm-ostree install virt-install libvirt-daemon-config-network libvirt-daemon-kvm qemu-kvm virt-manager virt-viewer

# Optional:

sudo rpm-ostree install libguestfs-tools python3-libguestfs virt-top

# Services:

sudo systemctl enable libvirtd
sudo systemctl start libvirtd
sudo systemctl status libvirtd # verify install

sudo virsh pool-list # list current storage pool
sudo virsh pool-destroy default # destroy default storage pool
sudo virsh pool-undefine default # undefine default storage pool

mkdir /home/[username]/kvm # create kvm directory
sudo virsh pool-define-as --name default --type dir --target /home/[username]/kvm # re-define default storage pool
sudo virsh pool-autostart default # autostart default storage pool
sudo virsh pool-start default # start default storage pool
sudo virsh pool-list # list current storage pool

sudo systemctl restart libvirtd
sudo systemctl status libvirtd



