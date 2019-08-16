#!/bin/bash

##
# Bash Vagrant Provisioning Script
#
# This script was set up to provision the following setup for config.vm.box = "bento/ubuntu-18.04":
#   - Apache2
#   - PHP7.3
#   - MariaDB
#   - Redis
#   - Composer
#
# @author Wes Crow
# @since 2019-08-07
##

##
# Variable data
##
apache_var_file="/etc/apache2/envvars"
apache_config_file="/etc/apache2/apache2.conf"
apache_vhost_file="/etc/apache2/sites-available/vagrant_vhost.conf"
php_config_file="/etc/php/7.3/apache2/php.ini"
mysql_config_file="/etc/mysql/my.cnf"
default_apache_index="/var/www/html/index.html"
project_web_root="/var/www"
server_name="codeday.local"
server_alias="*.codeday.local"

##
# This function is called at the very bottom of the file
##
main() {
	update_go
	network_go
  tools_go
	apache_go
	mysql_go
  php_go
  redis_go
  autoremove_go
	finally_go
  dynamit_go
} # End main function

###
# Update the OS
###
update_go() {
	apt-get update
} # End update

###
# Clean all of the things
###
autoremove_go() {
	apt-get -y autoremove
} # End autoremove

###
# Add the network info to the hosts file
###
network_go() {
	IPADDR=$(/sbin/ifconfig eth0 | awk '/inet / { print $2 }' | sed 's/addr://')
	sed -i "s/^${IPADDR}.*//" /etc/hosts
	echo ${IPADDR} ubuntu.localhost >> /etc/hosts			# Just to quiet down some error messages
	echo "127.0.0.1 ${server_name}" >> /etc/hosts
} # End update network

###
# Let's add some useful tools
###
tools_go() {
	apt-get -y install build-essential binutils-doc git nano zip unzip
} # End install tools

###
# All things Apache
###
apache_go() {

	# Install Apache
	apt-get -y install apache2

  # Define the server name to suppress stupid error
	echo "ServerName 127.0.0.1" >> ${apache_config_file}
	# Change AllowOverride None to AllowOverride All
	sed -i "s/^\(.*\)AllowOverride None/\1AllowOverride All/g" ${apache_config_file}

  # Set vagrant as the default apache user
	sed -i "s/^\(.*\)www-data/\1vagrant/g" ${apache_var_file}
	chown -R vagrant:vagrant /var/log/apache2

  # Add the necessary Apache modules
	a2enmod rewrite

  # Clear out web root
  rm -R ${project_web_root}/html

  # Define the virtual host
	if [ ! -f "${apache_vhost_file}" ]; then
		cat << EOF > ${apache_vhost_file}
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        ServerName ${server_name}
        ServerAlias ${server_alias}
        DocumentRoot ${project_web_root}
        <Directory ${project_web_root}>
            AllowOverride All
            Require all granted
        </Directory>
</VirtualHost>
EOF
	fi

  ## Clean up the sites-available
	a2dissite 000-default
	a2dissite default-ssl
	a2ensite vagrant_vhost

  # Get it going
	service apache2 reload

	# Remove old entries
	rm /etc/apache2/sites-available/000-default.conf
	rm /etc/apache2/sites-available/default-ssl.conf
} # End install Apache

###
# Install MySQL
###
mysql_go() {
    # Install MySQL
    echo "mysql-server mysql-server/root_password password root" | debconf-set-selections
    echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections
    apt-get -y install mysql-client mysql-server

    sed -i "s/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" ${mysql_config_file}

    # Allow root access from any host
    echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION" | mysql -u root --password=root
    echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY 'root' WITH GRANT OPTION" | mysql -u root --password=root
    echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'127.0.0.1' IDENTIFIED BY 'root' WITH GRANT OPTION" | mysql -u root --password=root
    echo "GRANT PROXY ON ''@'' TO 'root'@'%' WITH GRANT OPTION" | mysql -u root --password=root
    echo "GRANT PROXY ON ''@'' TO 'root'@'localhost' WITH GRANT OPTION" | mysql -u root --password=root
    echo "GRANT PROXY ON ''@'' TO 'root'@'127.0.0.1' WITH GRANT OPTION" | mysql -u root --password=root
    echo "CREATE DATABASE codeday" | mysql -u root --password=root
    echo ""
    echo "FINISHED"
    echo ""

    service mysql restart
    update-rc.d apache2 enable
} # End install MySQL

###
# Install PHP
###
php_go() {

	apt-get -y install software-properties-common
	add-apt-repository -y ppa:ondrej/php
	apt-get -y update

	apt-get -y install php7.3 php7.3-mysql php7.3-curl php-pear php7.3-redis php7.3-gd libapache2-mod-php7.3 php7.3-zip

	sed -i "s/display_startup_errors = Off/display_startup_errors = On/g" ${php_config_file}
	sed -i "s/display_errors = Off/display_errors = On/g" ${php_config_file}
	sed -i "s/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL/g" ${php_config_file}
	sed -i "s/html_errors = Off/html_errors = On/g" ${php_config_file}

	service apache2 restart

} # End install PHP

###
# Install Redis
###
redis_go() {
	apt-get -y install redis-server
	echo '127.0.0.1 redis' >> /etc/hosts
	service redis-server start
	apt-get -y install php-redis
	service apache2 restart
}

##
# Any additional stuff we need to do
##
finally_go() {

  # Need to force apache restart on mount
  sudo cat > /etc/init/vagrant-mounted.conf << EOL
# start services on vagrant mounted
start on vagrant-mounted
exec sudo service apache2 restart
EOL
}

###
# DynamItSpace
###
dynamit_go() {
  echo "/***************************************************************************************** "
  echo "* "
  echo "*      _                                                    _____________     __ "
  echo "*    /\ \                                                  /\_____   ____\   /\ \ "
  echo "*    \ \ \                                                 \/____/\  \___/   \ \ \ "
  echo "*     \ \ \                                                      \ \  \      _\_\ \___ "
  echo "*    __\_\ \    __    __    __  __      ___      __  _   __       \ \  \    /\___   ___\ "
  echo "*   /  __   \  /\ \  /\ \  /\ \`'   \   / __'\   /\ \`'  \`'  \       \ \  \   \/___/\ \__/ "
  echo "*  /\  \L\   \ \ \ \_\_\ \ \ \ \/'\ \ /\ \L\ \_ \ \ \'\ \'\ \   ____\_\  \____   \ \ \ "
  echo "*  \ \_____,__\ \ \______ \ \ \_\\ \_\\ \____,_\ \ \_\ \_\ \_\ / /\_____________\   \ \_\ "
  echo "*   \/____ /__/	\/_____/\ \ \/_/ \/_/ \/____/_/  \/_/\/_/\/_/   \/_____________/   \/_/ "
  echo "*                       \ \ \ "
  echo "*                      __\_\ \ "
  echo "*                    /\______/ "
  echo "*                    \/_____/ "
  echo "* "
  echo "* Copyright 2018 dynamIt Technologies, LLC. "
  echo "* "
  echo "* The following code is for the exclusive use of dynamIt Technologies, LLC. "
  echo "* Any use of this code with written permission from dynamIt is prohibited. "
  echo "* "
  echo "* Report an abuse of this copyright to "
  echo "*	dynamIt Technologies, LLC "
  echo "*	274 Marconi Boulevard, Suite 300 "
  echo "*	Columbus, Ohio 43215 USA "
  echo "*	+1.614.538.0095 "
  echo "* "
  echo "*****************************************************************************************/ "
}

main
exit 0