
# Tune TCP settings:

# As root:
su

#Set the max OS send buffer size (wmem) and receive buffer size (rmem) to 12 MB for queues on all protocols:
sudo echo 'net.core.wmem_max=12582912' >> /etc/sysctl.conf
sudo echo 'net.core.rmem_max=12582912' >> /etc/sysctl.conf

# Set minimum size, initial size, and maximum size in bytes:
sudo echo 'net.ipv4.tcp_rmem= 10240 87380 12582912' >> /etc/sysctl.conf
sudo echo 'net.ipv4.tcp_wmem= 10240 87380 12582912' >> /etc/sysctl.conf

# Turn on window scaling which can be an option to enlarge the transfer window:
sudo echo 'net.ipv4.tcp_window_scaling = 1' >> /etc/sysctl.conf

# Enable timestamps as defined in RFC1323:
sudo echo 'net.ipv4.tcp_timestamps = 1' >> /etc/sysctl.conf

# Enable select acknowledgments:
sudo echo 'net.ipv4.tcp_sack = 1' >> /etc/sysctl.conf

# TCP will not cache metrics on closing connections:
sudo echo 'net.ipv4.tcp_no_metrics_save = 1' >> /etc/sysctl.conf

# Set maximum number of packets, queued on the INPUT side, when the interface receives packets faster than kernel can process them:
echo 'net.core.netdev_max_backlog = 5000' >> /etc/sysctl.conf

# Reload the changes:
sudo sysctl -p
