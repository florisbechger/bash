
sudo apt update
sudo apt install lshw -y

# System Information:
sudo pkexec dmidecode -t01

# System firmware:
sudo pkexec dmesg | grep firmware

# System processor:
sudo lshw -C processor

# System memory:
sudo lshw -C memory

# Network interfaces:
sudo lshw -C network

# Configure SSD trim:
sudo systemctl enable fstrim.timer
sudo systemctl start fstrim.timer

# Low latency I/O for SATA ssd/hd:
sudo apt install sysfsutils
su
echo "# block/nvme0n1/queue/scheduler = deadline" >> /etc/sysfs.conf # This is not a sata-drive, this is a nvme-drive, so comment out

# WiFi + Bluetooth Driver firmware:
sudo rfkill
su # change to root
sudo git clone git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
cd /linux-firmware
cp iwlwifi-9000-pu-b0-jf-b0-38.ucode /lib/firmware
cp intel/ibt-17-16-1.sfi /lib/firmware/intel
cp intel/ibt-17-16-1.ddc /lib/firmware/intel
exit
sudo reboot

# WiFi + Bluetooth utilities:
sudo pkexec dmesg | grep -i wifi
sudo pkexec dmesg | grep -i bluetooth
sudo apt install bluetooth rfkill bluez bluez-tools
sudo apt install bluetooth rfkill gnome-bluetooth bluez bluez-tools

# Identify video GPU(s):
lspci | grep -E "VGA|3D"
sudo lspci | grep VGA # Active GPU

# README:
firefox "https://wiki.debian.org/NVIDIA%20Optimus"
firefox "https://wiki.debian.org/NvidiaGraphicsDrivers"




# Install video drivers:
sudo apt install bumblebee primus

# Nvidia Quadro P520:
sudo lshw -C video
sudo pkexec dmesg | grep -i video
# su
# sudo echo "deb http://deb.debian.org/debian buster-backports main contrib non-free" >> /etc/apt/sources.list
# exit
sudo apt update
sudo apt install -t buster-stable nvidia-driver firmware-misc-nonfree
sudo apt install -t buster-backports nvidia-driver firmware-misc-nonfree
sudo reboot
