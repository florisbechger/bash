#!/bin/bash

# Fedora Workstation/Silverblue 33 - Install 3

# remove obsolete versions:
sudo rpm-ostree status
sudo rpm-ostree cleanup -r
sudo rpm-ostree cleanup -b
sudo rpm-ostree cleanup -m

# check toolbox and enter your first container:
toolbox
toolbox list
toolbox create -c Test -y # Create Test
# toolbox enter -c Test
toolbox rm -f Test -y # Remove Test
# toolbox rm --force Test

# flatpak packages:
sudo flatpak install fedora geany libreoffice -y
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak remotes
sudo flatpak install flathub audacious filezilla mediawriter teams zoom -y

# install flatpak updates:
# sudo flatpak remotes
# sudo flatpak update

# cockpit package:
sudo rpm-ostree install cockpit-ostree cockpit cockpit-machines cockpit-podman cockpit-selinux virt-viewer
# sudo rpm-ostree install cockpit-storaged PackageKit

# sudo firewall-cmd --get-default-zone
sudo firewall-cmd --permanent --zone=FedoraWorkstation --add-service=cockpit
sudo firewall-cmd --reload

# cockpit check:
sudo echo "" >> cockpit.txt
sudo echo "lscpu | grep -i 'Model Name' # CPU name" >> cockpit.txt
sudo echo "grep -i -o vmx /proc/cpuinfo | uniq # Check VMX-flag" >> cockpit.txt
sudo echo "virt-host-validate # Check requirements" >> cockpit.txt
sudo echo "virsh version # Check QEMU version" >> cockpit.txt

# reboot:
sudo systemctl reboot

# END
