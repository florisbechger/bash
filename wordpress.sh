#!/bin/bash
#
# LAMP package installation:

dnf clean all
dnf update -y

dnf install curl tar wget unzip -y # Required

dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y # Repo epel latest versions on CentOS8
dnf install dnf-utils http://rpms.remirepo.net/enterprise/remi-release-8.rpm -y # Repo remi latest versions on CentOS8
dnf module reset php -y # Reset current php-version (7.2)
dnf module enable php:remi-7.4 -y # Enable latest php-version (7.4)

# dnf install https://rpms.remirepo.net/fedora/remi-release-32.rpm # Repo remi latest versions on Fedora32
# dnf config-manager --set-enabled remi-php74 # Enable latest php-version (7.4)
# dnf config-manager --set-enabled remi

dnf install httpd mariadb-server php php-pdo php-pecl-zip php-json php-common php-fpm php-mbstring php-cli php-mysqlnd php-json php-mbstring -y # Required
dnf install libapache2-mod-php php-opcache php-gd php-zip php-mcrypt php-xml php-gettext php-curl php-intl php-pear php-bcmath -y # Suggested Extra/Wordpress extensions

firewall-cmd --permanent --zone=public --add-service=http 
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload
systemctl reload firewalld

systemctl start mariadb
systemctl enable mariadb
systemctl start httpd
systemctl enable httpd

cd /var/www
wget https://wordpress.org/latest.tar.gz
tar xf latest.tar.gz
rm -v latest.tar.gz
cp -r wordpress /var/www/html
rm -r wordpress -f
chown -R apache:apache /var/www/html/wordpress
chcon -t httpd_sys_rw_content_t /var/www/html/wordpress -R # SE-Linux
# chcon -tR httpd_sys_rw_content_t /var/www

systemctl restart httpd

# php -v # output php version
# mysql -u root -p # no password?
# CREATE DATABASE wordpress;
# CREATE USER `admin`@`localhost` IDENTIFIED BY 'password';
# GRANT ALL ON wordpress.* TO `admin`@`localhost`;
# FLUSH PRIVILEGES;
# exit
# systemctl restart mariadb

# Plugins:
# https://wordpress.org/plugins/polylang/ # Multi language
# https://wordpress.org/plugins/search/folders/ # Folders
# https://wordpress.org/plugins/colibri-page-builder/ # Pagebuilder

# REF: https://blog.remirepo.net/post/2019/12/03/Install-PHP-7.4-on-CentOS-RHEL-or-Fedora
