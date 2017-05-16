#/**
#	Author : Prakhar Bhardwaj
#	Email : prakhar20@live.com
#
#	Server Setup Wizard
#
#	Guidelines 
#		1) Login As Root To Run This Script
#		2) Select Server Type
#		3) Select If You Need Browser
#		4) To Install IDEs
#		
#		
#		Modules Added Latest Versions 
#		Apache 2.0
#		Nginx
#		Maria-Db
#		Mysql
#		Php 
#		Phpmyadmin
#		GIT
#		Sublime
#		Mozilla
#		Chrome
#**/

#!/bin/bash


#color
RED='\033[0;31m'
NC='\033[0m' # No Color
GREEN='\033[0;32m'
BLUE='\033[0;34m'


if [[ $EUID -ne 0 ]]; then
   echo "Please Change User To ${RED}Root" 
   exit 1
fi


apache ()
{
	clear
	echo "Installing ${BLUE}Apache2"
	apt-get install apache2
	echo "${BLUE}Apache2 Installation ${GREEN}Complete"
	
}
nginx ()
{
	clear
	echo "Installing ${BLUE}Nginx..."
	apt-get install nginx
	echo "${BLUE}Nginx.. Installation ${GREEN}Complete!!"
	echo "You Can Now Configure Nginx"
}

mariadb ()
{
	clear
	echo "Installing ${BLUE}Maria-Db"	
	apt-get install mariadb-server mariadb-client
	echo "${BLUE}Maria-Db Installation ${GREEN}Complete"
}

php ()
{
	clear
	echo "Installing ${BLUE}PHP Latest Version Avaialble"
	apt-get install php-fpm php-mysql
	echo "Installing ${BLUE}Essential PHP Mods"
	apt-get install php7.0-curl
	echo "${BLUE}PHP Installation ${GREEN}Complete"
}

mysql ()
{
	clear
	echo "Installing ${BLUE}Mysql Server"
	apt-get install mysql-server mysql-client
	echo "${BLUE}Mysql Installation ${GREEN}Complete"
}

phpmyadmin ()
{
	clear
	echo "Installing ${BLUE}phpmyadmin"
	apt-get install phpmyadmin
	ln -s /usr/share/phpmyadmin/ /var/www/html
	echo "${BLUE}Phpmyadmin Installation ${GREEN}Complete"
}


git ()
{
	clear
	echo "Installing ${BLUE}GIT"
	apt-get install git
	echo "${BLUE}GIT Installation ${GREEN}Complete..."
}

sublime ()
{
	clear
	echo "Getting Sublime For You.."
	wget -O /tmp/sublime-text_build-3126_amd64.deb https://download.sublimetext.com/sublime-text_build-3126_amd64.deb
	echo "Installing ${BLUE}Sublime...."
	dpkg -i /tmp/sublime-text_build-3126_amd64.deb
	apt-get install -f
	echo "${BLUE}Sublime Installation ${GREEN}Complete"
}



chrome ()
{
	clear
	echo "Getting Chrome For You"
	wget -O /tmp/google-chrome-stable_current_amd64.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	echo "Installing.${BLUE}..."
	dpkg -i /tmp/google-chrome-stable_current_amd64.deb
	apt-get install -f
	echo "${BLUE}Chrome Installation ${GREEN}Complete"
}

mozilla ()
{
	clear	
	echo "Getting Firefox For You"
	wget -O /tmp/firefox-54.0b7.tar.bz2 http://ftp.mozilla.org/pub/firefox/releases/54.0b7/linux-x86_64/en-US/firefox-54.0b7.tar.bz2
	echo "Installing.${BLUE}..."
	mv /tmp/firefox-54.0b7.tar.bz2 /opt
	tar xvjf firefox-54.0b7.tar.bz2
	ln -s /opt/firefox/firefox /usr/bin/firefox
	echo "${BLUE}Firefox Installation ${GREEN}Complete"

}



restart ()
{
clear
echo "Your Services Will Restart Now And Your ${RED}/tmp will be ${GREEn}cleared"
service apache2 restart
service nginx restart
service php-fpm restart
service mysql restart
apt autoremove
apt-get clean
rm -rf /tmp/*
}






browser ()
{
	clear 
	echo "Please Select Your Browser"
	echo "[1]Chrome"
	echo "[2]Mozilla"
	echo "[3]Both"
	echo "[4]Skip This Step"
	echo "Option:: "
	while true; do
    read -p "" opt
	    case $opt in
	        [1]* ) chrome; break;;
	        [2]* ) mozilla; break;;
	        [3]* ) chrome; mozilla; break;;
	        [4]* ) break;;
	        * ) echo "Please answer from options.";;
	    esac
	done	
}

database ()
{
	echo "Enter"
	echo "[1] for Maria-Db"
	echo "[2] for MySql"

	while true; do

    read -p "Option:: " yn
	    case $yn in
	        [1]* ) mariadb; break;;
	        [2]* ) mysql; break;;
	        * ) echo "Please answer from options Available \n";;
		esac
	done
}

ide ()
{
	sublime
}



Lemp ()
{
	
	nginx
	database
	php
	phpmyadmin
	git

}

Lamp ()
{
	apache
	database
	php
	phpmyadmin
	git

}

echo "Enter"
echo "[1] for LEMP"
echo "[2] for LAMP"
echo "OR Type exit To Quit"

while true; do

    read -p "Option:: " yn
    case $yn in
        [1]* ) Lemp; break;;
        [2]* ) Lamp; break;;
		[exitEXITExit]* ) exit;;
        * ) echo "Please answer from options ${BLUE}Available \n";;
	esac
done



while true; do
    read -p "Do You Need A Browser...?" yn
    case $yn in
        [Yy]* ) browser; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done


while true; do
    read -p "Do You Need A IDE...?" yn
    case $yn in
        [Yy]* ) ide; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done





while true; do
    read -p "Have You Configured Your Development Enviornment And Ready To  Apply Settings..?" yn
    case $yn in
        [Yy]* ) restart; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

