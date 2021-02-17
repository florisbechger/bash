
sudo apt-get update
sudo apt-get install gnome-power-manager htop lshw neofetch thermald -y
sudo systemctl enable thermald
sudo systemctl start thermald

# System Information:
sudo dmidecode -t01
# System firmware:
sudo dmesg | grep firmware
# System processor:
sudo lshw -C processor
# System memory:
sudo lshw -C memory
# Network interfaces:
sudo lshw -C network

# Configure SSD trim:
sudo systemctl enable fstrim.timer
sudo systemctl start fstrim.timer

# WiFi + Bluetooth utilities:
sudo pkexec dmesg | grep -i wifi
sudo pkexec dmesg | grep -i bluetooth

# Battery management:
sudo apt install tlp -y
sudo systemctl enable tlp
sudo systemctl start tlp

# Firewall:
sudo apt install firewalld firewall-config firewall-applet -y

# Antivirus:
sudo apt install clamav clamtk -y

# Sensors:
sudo apt install acpi lm-sensors -y
sensors-detect
cat /etc/sensors3.conf # check

sudo echo "" >> ~/.bashrc
sudo echo "# Custom:" >> ~/.bashrc
sudo echo "echo" >> ~/.bashrc
sudo echo "sensors -A" >> ~/.bashrc
sudo echo "acpi -b" >> ~/.bashrc
sudo echo "acpi -t" >> ~/.bashrc
sudo echo "acpi -a" >> ~/.bashrc
sudo echo "echo" >> ~/.bashrc
sudo echo "neofetch" >> ~/.bashrc

# Low latency I/O for SATA ssd/hd:
sudo apt install sysfsutils
su
echo "# block/nvme0n1/queue/scheduler = deadline" >> /etc/sysfs.conf # This is not a sata-drive, this is a nvme-drive, so comment #
exit

# Thinkpad driver configuration:

# Download:
cd ~/Downloads
wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/snapshot/linux-firmware-20210208.tar.gz
tar -xvf linux-firmware-20210208.tar.gz
cd linux-firmware-20210208

# Firmware:
sudo cp iwlwifi-9000-pu-b0-jf-b0-34.ucode /lib/firmware
sudo cp iwlwifi-9000-pu-b0-jf-b0-38.ucode /lib/firmware
sudo cp iwlwifi-9000-pu-b0-jf-b0-41.ucode /lib/firmware
sudo cp iwlwifi-9000-pu-b0-jf-b0-46.ucode /lib/firmware

sudo mkdir /lib/firmware/intel
sudo cp intel/ibt-17-16-1.* /lib/firmware/intel
sudo mkdir /lib/firmware/i915
sudo cp i915/*_dmc_ver1_04.* /lib/firmware/i915
ls -la /lib/firmware/intel # check
ls -la /lib/firmware/i915 # check

# Identify video GPU(s):
sudo lspci | grep -E "VGA|3D"
sudo lspci | grep VGA # Active GPU
sudo lspci -k | grep -EA2 "VGA|3D|Display"

# Nvidia Quadro P520:
sudo lshw -C video
sudo pkexec dmesg | grep -i video
sudo apt remove nvidia*
sudo apt autoremove

sudo apt install nvidia-detect
sudo nvidia-detect

# Standard Kernel support + NVidia:
sudo apt update
sudo apt install linux-headers-amd64
sudo apt install -t buster nvidia-driver firmware-misc-nonfree
sudo reboot

# Kernel 5.10x support + NVidia (buster-backports):
su # change to root
sudo echo "deb http://deb.debian.org/debian buster-backports main contrib non-free" >> /etc/apt/sources.list
exit
sudo apt update
sudo apt install -t buster-backports linux-image-amd64
sudo apt install -t buster-backports nvidia-driver firmware-misc-nonfree
sudo reboot
