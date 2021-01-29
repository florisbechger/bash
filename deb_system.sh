
sudo apt-get update
sudo apt-get install git htop lshw neofetch -y

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

# sudo apt-get install bluetooth rfkill bluez bluez-tools
sudo apt-get install bluetooth rfkill gnome-bluetooth bluez bluez-tools -y

# Driver firmware:
sudo apt-get install firmware-linux-nonfree -y
sudo apt-get install watchdog -y
sudo rfkill
git clone git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
cd linux-firmware
su # change to root
cp iwlwifi-9000-pu-b0-jf-b0-38.ucode /lib/firmware
mkdir /lib/firmware/intel
cp intel/ibt-17-16-1.* /lib/firmware/intel
mkdir /lib/firmware/i915
cp i915/kbl_dmc_ver1_04.* /lib/firmware/i915
ls -l /lib/firmware/intel
ls -l /lib/firmware/i915
exit
sudo reboot

# Sensors:
sudo apt-get install acpi lm-sensors -y
sensors-detect
# sudo nano /etc/sensors3.conf

sudo echo "" >> ~/.bashrc
sudo echo "# Custom:" >> ~/.bashrc
sudo echo "echo" >> ~/.bashrc
sudo echo "sensors -A" >> ~/.bashrc
sudo echo "acpi -b" >> ~/.bashrc
sudo echo "acpi -t" >> ~/.bashrc
sudo echo "acpi -a" >> ~/.bashrc
sudo echo "echo" >> ~/.bashrc
sudo echo "neofetch" >> ~/.bashrc

# Identify video GPU(s):
lspci | grep -E "VGA|3D"
sudo lspci | grep VGA # Active GPU
su
# apt install nvidia-detect -y
# nvidia-detect

# Nvidia Quadro P520:
sudo lshw -C video
sudo pkexec dmesg | grep -i video
# su
# sudo echo "deb http://deb.debian.org/debian buster-backports main contrib non-free" >> /etc/apt/sources.list
# exit
sudo apt-get update
sudo apt-get install -t buster nvidia-driver firmware-misc-nonfree
sudo apt-get install -t buster-backports nvidia-driver firmware-misc-nonfree
sudo reboot

# Low latency I/O for SATA ssd/hd:
sudo apt-get install sysfsutils
su
echo "# block/nvme0n1/queue/scheduler = deadline" >> /etc/sysfs.conf # This is not a sata-drive, this is a nvme-drive, so comment out

# README:
firefox "https://averagelinuxuser.com/debian-10-after-install"
firefox "https://wiki.debian.org/NVIDIA%20Optimus"
firefox "https://wiki.debian.org/NvidiaGraphicsDrivers"
