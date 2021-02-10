
# centos installation packages:
# http://linux.cs.uu.nl/centos/8-stream/BaseOS/x86_64/os/

# upgrade all packages
dnf upgrade -y

# disable selinux
/sbin/setenforce 0

# install EPEL repository
dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y

# enable PowerTools
dnf config-manager --set-enabled PowerTools -y

# basic system settings
hostnamectl set-hostname fedora --static
nmcli con mod enp0s3 ipv4.address 10.0.2.100/24
nmcli con mod enp0s3 ipv4.gateway 10.0.2.1
nmcli con mod enp0s3 ipv4.dns "208.67.220.220 208.67.222.222"
nmcli con mod enp0s3 ipv4.method manual
nmcli con mod enp0s3 connection.autoconnect yes
nmcli con mod enp0s8 ipv4.address 192.168.178.100/24
nmcli con mod enp0s8 ipv4.gateway 192.168.178.1
# nmcli con mod enp0s8 ipv4.dns "89.101.251.228 89.101.251.229" # Ziggo
nmcli con mod enp0s8 ipv4.dns "194.109.6.66 194.109.9.99 194.109.104.104" # xs4all
nmcli con mod enp0s8 ipv4.method manual
nmcli con mod enp0s8 connection.autoconnect yes
systemctl restart systemd-hostnamed
systemctl restart NetworkManager

# firewall configuration
timedatectl >> README.TXT
firewall-cmd --permanent --zone=public --add-service=cockpit
firewall-cmd --permanent --zone=public --add-service=dns
firewall-cmd --permanent --zone=public --add-service=ntp
firewall-cmd --permanent --zone=public --add-service=ptp
firewall-cmd --permanent --zone=public --add-service=ssh
firewall-cmd --reload

# package installation
dnf install epel-release -y
dnf config-manager --set-enabled PowerTools -y
dnf upgrade-minimal -y

# grab all packages to install
sudo dnf install $(cat ~/install.packages) -y

# cleanup dependencies
dnf clean all
