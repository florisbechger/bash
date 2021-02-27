
# Fedora Silverblue 33 - Install 3

# enable Thermals:
sudo systemctl status thermald
# sudo systemctl enable thermald
# sudo systemctl start thermald

# enable Battery management:
sudo systemctl status tlp
# sudo systemctl enable tlp
# sudo systemctl start tlp

# remove obsolete versions:
sudo rpm-ostree status
sudo rpm-ostree cleanup -r
sudo rpm-ostree cleanup -b
sudo rpm-ostree cleanup -m

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
