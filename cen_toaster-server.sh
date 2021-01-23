
#!/bin/bash

# https://www.yoctoproject.org/docs/3.1.1/toaster-manual/toaster-manual.html#toaster-setting-up-a-production-instance-of-toaster

# Basic requirements for CentOS 8:
sudo dnf clean all -y # clean the DNF package repositorycaches
sudo dnf makecache -y # update the DNF package repository cache
sudo dnf upgrade-minimal -y # only install absolutely required security patches
sudo dnf autoremove -y # remove unnecessary packages if available

# sudo dnf upgrade # full system update
# Check all enabled repositories
# sudo dnf repolist # list all available repositories on your system
# sudo dnf repolist --enabled # list all enabled repositories on your system
# sudo dnf repolist --disabled # list all disabled repositories on your system
# sudo dnf repolist --all # list all available repositories available (a very very long list!)
# sudo dnf search "Virtual Machines" # Search for available packages
# sudo dnf repoquery *kvm* # Search for a specific package
# sudo dnf list --installed # list all installed packages on your system

# install repo:
sudo dnf install epel-release -y
sudo dnf config-manager --set-enabled PowerTools # PowerTools repo provides additional packages such as rpcgen and texinfo
sudo dnf makecache # makecache command consumes additional Metadata from epel-release

# install basic packages:
sudo dnf install httpd mariadb-server mariadb-devel python3 python3-devel python3-mod_wsgi python3-pip -y

# install additional packages:
sudo dnf install bzip2 chrpath diffstat gcc gcc-c++ git make patch rpcgen tar -y

# firewall config:
sudo firewall-cmd --permanent --zone=public --add-port=8000/tcp
sudo firewall-cmd --reload
sudo systemctl reload firewalld

# start services:
systemctl start mariadb
systemctl enable mariadb
systemctl start httpd
systemctl enable httpd

# create user toaster:
sudo /usr/sbin/useradd toaster -md /var/www/toaster -s /bin/false

# change to user toaster:
sudo su - toaster -s /bin/bash

# clone poky:
sudo git clone git://git.yoctoproject.org/poky # clone poky
sudo git checkout dunfell # select dunfell

# clone poky:
sudo cd /var/www/toaster/
sudo git clone git://git.yoctoproject.org/poky --progress # clone poky
sudo git checkout dunfell --progress # select dunfell

# edit the DATABASES settings:
sudo echo '' > /var/www/toaster/poky/bitbake/lib/toaster/toastermain/settings.py
sudo echo 'DATABASES = {' >> /var/www/toaster/poky/bitbake/lib/toaster/toastermain/settings.py
sudo echo '       'default': {' >> /var/www/toaster/poky/bitbake/lib/toaster/toastermain/settings.py
sudo echo '           'ENGINE': 'django.db.backends.mysql',' >> /var/www/toaster/poky/bitbake/lib/toaster/toastermain/settings.py
sudo echo '           'NAME': 'toaster_data',' >> /var/www/toaster/poky/bitbake/lib/toaster/toastermain/settings.py
sudo echo '           'USER': 'toaster',' >> /var/www/toaster/poky/bitbake/lib/toaster/toastermain/settings.py
sudo echo '           'PASSWORD': 'password',' >> /var/www/toaster/poky/bitbake/lib/toaster/toastermain/settings.py
sudo echo '           'HOST': 'localhost',' >> /var/www/toaster/poky/bitbake/lib/toaster/toastermain/settings.py
sudo echo '           'PORT': '3306',' >> /var/www/toaster/poky/bitbake/lib/toaster/toastermain/settings.py
sudo echo '      }' > /var/www/toaster/poky/bitbake/lib/toaster/toastermain/settings.py
sudo echo '   }' > /var/www/toaster/poky/bitbake/lib/toaster/toastermain/settings.py

# edit the SECRET_KEY:
sudo echo '' >> /var/www/toaster/poky/bitbake/lib/toaster/toastermain/settings.py
sudo echo 'SECRET_KEY = 'toaster'' >> /var/www/toaster/poky/bitbake/lib/toaster/toastermain/settings.py

# edit the STATIC_ROOT:
sudo echo '' >> /var/www/toaster/poky/bitbake/lib/toaster/toastermain/settings.py
sudo echo 'STATIC_ROOT = '/var/www/toaster/static_files/'' >> /var/www/toaster/poky/bitbake/lib/toaster/toastermain/settings.py

# add the database and user to the mysql server defined earlier:
sudo mysql -u root -p
CREATE DATABASE toaster_data;
CREATE USER 'toaster'@'localhost' identified by 'password';
GRANT all on toaster_data.* to 'toaster'@'localhost';
quit

# get Toaster to create the database schema, default data, and gather the statically-served files:
cd  /var/www/toaster/poky/
./bitbake/lib/toaster/manage.py migrate
TOASTER_DIR=`pwd` TEMPLATECONF='poky' \
./bitbake/lib/toaster/manage.py checksettings
./bitbake/lib/toaster/manage.py collectstatic

# start Toaster:
sudo source /home/toaster/poky/oe-init-build-env
sudo source toaster start webport=192.168.0.90:8000

# add an Apache configuration file for Toaster:
sudo echo '' > /etc/httpd/conf.d/toaster.conf
sudo echo 'Alias /static /var/www/toaster/static_files' >> /etc/httpd/conf.d/toaster.conf
sudo echo '   <Directory /var/www/toaster/static_files>' >> /etc/httpd/conf.d/toaster.conf
sudo echo '           <IfModule mod_access_compat.c>' >> /etc/httpd/conf.d/toaster.conf
sudo echo '                   Order allow,deny' >> /etc/httpd/conf.d/toaster.conf
sudo echo '                   Allow from all' >> /etc/httpd/conf.d/toaster.conf
sudo echo '           </IfModule>' >> /etc/httpd/conf.d/toaster.conf
sudo echo '           <IfModule !mod_access_compat.c>' >> /etc/httpd/conf.d/toaster.conf
sudo echo '                   Require all granted' >> /etc/httpd/conf.d/toaster.conf
sudo echo '           </IfModule>' >> /etc/httpd/conf.d/toaster.conf
sudo echo '   </Directory>' >> /etc/httpd/conf.d/toaster.conf
sudo echo '' >> /etc/httpd/conf.d/toaster.conf
sudo echo '   <Directory /var/www/toaster/poky/bitbake/lib/toaster/toastermain>' >> /etc/httpd/conf.d/toaster.conf
sudo echo '           <Files "wsgi.py">' >> /etc/httpd/conf.d/toaster.conf
sudo echo '              Require all granted' >> /etc/httpd/conf.d/toaster.conf
sudo echo '           </Files>' >> /etc/httpd/conf.d/toaster.conf
sudo echo '   </Directory>' >> /etc/httpd/conf.d/toaster.conf
sudo echo '' >> /etc/httpd/conf.d/toaster.conf
sudo echo '   WSGIDaemonProcess toaster_wsgi python-path=/var/www/toaster/poky/bitbake/lib/toaster:/var/www/toaster/.local/lib/python3.4/site-packages' >> /etc/httpd/conf.d/toaster.conf
sudo echo '' >> /etc/httpd/conf.d/toaster.conf
sudo echo '   WSGIScriptAlias / "/var/www/toaster/poky/bitbake/lib/toaster/toastermain/wsgi.py"' >> /etc/httpd/conf.d/toaster.conf
sudo echo '   <Location />' >> /etc/httpd/conf.d/toaster.conf
sudo echo '       WSGIProcessGroup toaster_wsgi' >> /etc/httpd/conf.d/toaster.conf
sudo echo '   </Location>' >> /etc/httpd/conf.d/toaster.conf
sudo echo '' >> /etc/httpd/conf.d/toaster.conf

# restart Apache to make sure all new configuration is loaded:
sudo service httpd restart

# Prepare the systemd service to run Toaster builds: ????

[Unit]
Description=Toaster runbuilds

[Service]
Type=forking
User=toaster
ExecStart=/usr/bin/screen -d -m -S runbuilds /var/www/toaster/poky/bitbake/lib/toaster/runbuilds-service.sh start
ExecStop=/usr/bin/screen -S runbuilds -X quit
WorkingDirectory=/var/www/toaster/poky

[Install]
WantedBy=multi-user.target

# prepare the runbuilds-service.sh script that you need to place in the /var/www/toaster/poky/bitbake/lib/toaster/ directory by setting up executable permissions:
sudo echo '' > /runbuilds-service.sh
sudo echo '#!/bin/bash' >> /runbuilds-service.sh
sudo echo '' >> /runbuilds-service.sh
sudo echo '   #export http_proxy=http://proxy.host.com:8080' >> /runbuilds-service.sh
sudo echo '   #export https_proxy=http://proxy.host.com:8080' >> /runbuilds-service.sh
sudo echo '   #export GIT_PROXY_COMMAND=$HOME/bin/gitproxy' >> /runbuilds-service.sh
sudo echo '' >> /runbuilds-service.sh
sudo echo '   cd ~/poky/' >> /runbuilds-service.sh
sudo echo '   source ./oe-init-build-env build' >> /runbuilds-service.sh
sudo echo '   source ../bitbake/bin/toaster $1 noweb' >> /runbuilds-service.sh
sudo echo '   [ "$1" == 'start' ] && /bin/bash' >> /runbuilds-service.sh
sudo echo '' >> /runbuilds-service.sh

sudo cp runbuilds-service.sh /var/www/toaster/poky/bitbake/lib/toaster/

# run the service:
sudo service runbuilds start

#  Since the service is running in a detached screen session, you can attach to it using this command:

#  $ sudo su - toaster
#  $ screen -rS runbuilds

#  You can detach from the service again using "Ctrl-a" followed by "d" key combination. 
                      