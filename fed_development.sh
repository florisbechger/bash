
# Development

sudo dnf groupinstall "Headless Management"

# Flatpak installation:
sudo dnf install flatpak flatpak-selinux flatpak-session-helper -y
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak remotes # Flatpak synchronize

# Toolbox installation:
# sudo dnf install git -y # Git installation
# sudo git clone 'https://github.com/containers/toolbox.git' # Clone Toolbox git
sudo dnf install toolbox -y

# Check CPU has Intel VT or AMD-V Virtualization extensions
sudo lscpu | grep Virtualization

# KVM installation:
sudo dnf install qemu-kvm libvirt libguestfs-tools virt-install rsync virt-viewer -y
# virt-manager has been deprecated as of RHEL 8, use Cockpit instead:

# Cockpit installation:
sudo dnf install cockpit cockpit-machines cockpit-podman cockpit-selinux cockpit-storaged virt-viewer -y # (cockpit-pcp)
# sudo hosted-engine --deploy --ansible-extra-vars=he_ipv4_subnet_prefix=192.168.222 # Command under construction

# Enable Cockpit:
sudo firewall-cmd --permanent --zone=FedoraWorkstation --add-service=cockpit
sudo firewall-cmd --permanent --zone=FedoraWorkstation --add-service=dns
sudo firewall-cmd --permanent --zone=FedoraWorkstation --add-service=ntp
sudo firewall-cmd --reload
sudo systemctl enable cockpit.socket
sudo systemctl enable libvirtd.service
# visit cockpit: localhost:9090

# Ovirt's Cockpit installation:
sudo dnf install https://resources.ovirt.org/pub/yum-repo/ovirt-release44.rpm
sudo dnf install cockpit cockpit-ovirt-dashboard -y

# VirtualBox installation (CentOS):
sudo dnf config-manager --add-repo=https://download.virtualbox.org/virtualbox/rpm/el/virtualbox.repo
sudo dnf install VirtualBox-6.1-6.1.16_140961_el8-1.x86_64.rpm -y

# VirtualBox installation (Fedora):
sudo dnf config-manager --add-repo=https://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo
sudo dnf install VirtualBox-6.1-6.1.16_140961_fedora32-1.x86_64.rpm

# VirtualBox Extension_Pack installation:
sudo wget https://download.virtualbox.org/virtualbox/6.0.16/Oracle_VM_VirtualBox_Extension_Pack-6.0.16.vbox-extpack
sudo VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-6.0.16.vbox-extpack -y

# sudo ausearch -c 'firewalld' --raw | audit2allow -M my-firewalld
# sudo semodule -i my-firewalld.pp

# REF: https://access.redhat.com/documentation/en-us/red_hat_virtualization/4.4/html/installing_red_hat_virtualization_as_a_self-hosted_engine_using_the_cockpit_web_interface/index

