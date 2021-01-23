#!/bin/bash

# Fedora Workstation/Silverblue 32 - Lamp install

# https://fedoramagazine.org/howto-install-wordpress-fedora/
# https://tecadmin.net/install-lamp-on-fedora/

# install packages:
sudo rpm-ostree install httpd mariadb-server php php-cli php-php-gettext php-mbstring php-mcrypt php-mysqlnd php-pear php-curl php-gd php-xml php-bcmath php-zip

# install wordpress:
sudo rpm-ostree install wordpress # php-mysqlnd mariadb-server

# firewall configuration:
sudo firewall-cmd --permanent --zone=FedoraWorkstation --add-service=http
sudo firewall-cmd --permanent --zone=FedoraWorkstation --add-service=https
sudo firewall-cmd --permanent --zone=FedoraWorkstation --add-service=mysql
sudo firewall-cmd --reload

# reboot:
sudo systemctl reboot

# add these lines to /var/www/html/phpinfo.php:
sudo echo "<?php" >> /var/www/html/phpinfo.php
sudo echo "  phpinfo();" >> /var/www/html/phpinfo.php
sudo echo "?>" >> /var/www/html/phpinfo.php

# start and enable services:
sudo systemctl start httpd
sudo systemctl enable httpd
sudo systemctl start mariadb
sudo systemctl enable mariadb

mysql_secure_installation
mysql -u root -p
sudo systemctl reload httpd

# END
