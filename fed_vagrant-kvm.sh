# Vagrant qemu kvm:

# Install qemu-kvm:
sudo dnf install qemu-kvm libvirt libguestfs-tools virt-install rsync -y

# Enable and start the libvirt daemon::
sudo systemctl enable --now libvirtd

# Install Vagrant:
sudo dnf install vagrant -y

# Install the Vagrant libvirtd plugin:
sudo vagrant plugin install vagrant-libvirt

# Add a box (test):
vagrant box add fedora/33-cloud-base --provider=libvirt

# Create a minimal Vagrantfile to test:
mkdir vagrant-test
cd vagrant-test
sudo echo '# vagrant-test configuration:' > Vagrantfile
sudo echo 'Vagrant.configure("2") do |config|' >> Vagrantfile
sudo echo '  config.vm.box = "fedora/33-cloud-base"' >> Vagrantfile
sudo echo 'end' >> Vagrantfile

# Check the file:
vagrant status

# Start the box:
vagrant up
