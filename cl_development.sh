
# Development Packages for vanilla ClearLinux on laptop

# Install KVM for kernel and host:
sudo swupd update # run update first
sudo sudo swupd bundle-add kernel-kvm kvm-host # install bundles
sudo usermod -G kvm -a [username] # add user to group kvm
sudo systemctl enable libvirtd # enable libvirtd service

# Basic commands:
sudo virsh list --all # verify which vm is running
sudo virsh shutdown [computername] # shutdown vm before cloning
sudo virt-clone --original [computername] --name [computername][-new] --auto-clone # clone vm
sudo virsh start [computername][-new] # run clone
sudo virsh list --all # verify

sudo virsh shutdown [computername] # shutdown vm
sudo virsh undefine --domain [computername] --storage /var/lib/libvirt/images/[computername].qcow2 --wipe-storage # delete vm & wipe disk
sudo ls -la /var/lib/libvirt/images/ # verify

# Bare-Server configuration

# create kvm-network:
sudo -i # change to root
mkdir /etc/systemd/network/
# create kvm-network interface:
echo "[NetDev]" > /etc/systemd/network/br0.netdev
echo "Name=br0" >> /etc/systemd/network/br0.netdev
echo "Kind=bridge" >> /etc/systemd/network/br0.netdev
# create kvm-network configuration:
echo "[Match]" > /etc/systemd/network/br0.network
echo "Name=br0" >> /etc/systemd/network/br0.network
echo "[Network]" >> /etc/systemd/network/br0.network
echo "DHCP=yes" >> /etc/systemd/network/br0.network
echo "Address=10.0.0.2/16" >> /etc/systemd/network/br0.network
echo "Gateway=10.0.0.1" >> /etc/systemd/network/br0.network
echo "DNS=10.0.0.1" >> /etc/systemd/network/br0.network
echo "DNS=192.168.0.1" >> /etc/systemd/network/br0.network
# change Name=en* to Name=*0s*:
sed -i 's/Name=en/Name=*p0s/g' /lib/systemd/network/80-dhcp.network
# configure bridge for ip-tables:
mkdir /etc/sysctl.d/
echo "net.bridge.bridge-nf-call-arptables = 0" > /etc/sysctl.d/80-bridge.conf
echo "net.bridge.bridge-nf-call-ip6tables = 0" >> /etc/sysctl.d/80-bridge.conf
echo "net.bridge.bridge-nf-call-iptables = 0" >> /etc/sysctl.d/80-bridge.conf
# restart services:
sudo systemctl restart systemd-networkd
networkctl
exit # exit root
