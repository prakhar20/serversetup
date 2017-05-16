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
   printf "Please Change User To ${RED}Root\n" 
   exit 1
fi


apache ()
{
	clear
	echo -e "Installing ${BLUE}Apache2"
	apt-get install apache2
	echo -e "${BLUE}Apache2\033[0m Installation ${GREEN}Complete\033[0m"
	
}
nginx ()
{
	clear
	echo -e "Installing ${BLUE}Nginx..."
	apt-get install nginx
	echo -e "${BLUE}Nginx..\033[0m Installation ${GREEN}Complete!! \033[0m";
	echo -e "You Can Now Configure Nginx"
}

mariadb ()
{
	clear
	echo -e "Installing ${BLUE}Maria-Db\033[0m"	
	apt-get install mariadb-server mariadb-client
	echo -e "${BLUE}Maria-Db\033[0m Installation ${GREEN}Complete\033[0m"
}

php ()
{
	clear
	echo -e "Installing ${BLUE}PHP Latest Version Avaialble\033[0m"
	apt-get install php-fpm php-mysql
	echo -e "Installing ${BLUE}Essential PHP Mods\033[0m"
	apt-get install php7.0-curl
	echo -e "${BLUE}PHP\033[0m Installation ${GREEN}Complete\033[0m"
}

mysql ()
{
	clear
	echo -e "Installing ${BLUE}Mysql Server\033[0m"
	apt-get install mysql-server mysql-client
	echo -e "${BLUE}Mysql\033[0m Installation ${GREEN}Complete\033[0m"
}

phpmyadmin ()
{
	clear
	echo -e "Installing ${BLUE}phpmyadmin\033[0m"
	apt-get install phpmyadmin
	ln -s /usr/share/phpmyadmin/ /var/www/html
	echo -e "${BLUE}Phpmyadmin\033[0m Installation ${GREEN}Complete\033[0m"
}


git ()
{
	clear
	echo -e "Installing ${BLUE}GIT\033[0m"
	apt-get install git
	echo -e "${BLUE}GIT\033[0m Installation ${GREEN}Complete...\033[0m"
}

sublime ()
{
	clear
	echo -e "Getting Sublime For You.."
	wget -O /tmp/sublime-text_build-3126_amd64.deb https://download.sublimetext.com/sublime-text_build-3126_amd64.deb
	echo -e "Installing ${BLUE}Sublime....\033[0m"
	dpkg -i /tmp/sublime-text_build-3126_amd64.deb
	apt-get install -f
	echo -e "${BLUE}Sublime\033[0m Installation ${GREEN}Complete\033[0m"
}



chrome ()
{
	clear
	echo -e "Getting Chrome For You"
	wget -O /tmp/google-chrome-stable_current_amd64.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	echo -e "Installing.${BLUE}Chrome...\033[0m"
	dpkg -i /tmp/google-chrome-stable_current_amd64.deb
	apt-get install -f
	echo -e "${BLUE}Chrome\033[0m Installation ${GREEN}Complete\033[0m"
}

mozilla ()
{
	clear	
	echo -e "Getting Firefox For You"
	wget -O /tmp/firefox-54.0b7.tar.bz2 http://ftp.mozilla.org/pub/firefox/releases/54.0b7/linux-x86_64/en-US/firefox-54.0b7.tar.bz2
	echo -e "Installing.${BLUE}Mozilla...\033[0m"
	mv /tmp/firefox-54.0b7.tar.bz2 /opt
	tar xvjf firefox-54.0b7.tar.bz2
	ln -s /opt/firefox/firefox /usr/bin/firefox
	echo -e "${BLUE}Firefox\033[0m Installation ${GREEN}Complete\033[0m"

}



restart ()
{
clear
echo -e "Your Services Will Restart Now And Your ${RED}/tmp\033[0m will be ${GREEN}cleared\033[0m"
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
	echo -e "Please Select Your Browser"
	echo -e "[1]Chrome"
	echo -e "[2]Mozilla"
	echo -e "[3]Both"
	echo -e "[4]Skip This Step"
	echo -e "Option:: "
	while true; do
    read -p "" opt
	    case $opt in
	        [1]* ) chrome; break;;
	        [2]* ) mozilla; break;;
	        [3]* ) chrome; mozilla; break;;
	        [4]* ) break;;
	        * ) echo -e "Please answer from options.";;
	    esac
	done	
}

database ()
{
	echo -e "Enter"
	echo -e "[1] for Maria-Db"
	echo -e "[2] for MySql"

	while true; do

    read -p "Option:: " yn
	    case $yn in
	        [1]* ) mariadb; break;;
	        [2]* ) mysql; break;;
	        * ) echo -e "Please answer from options Available \n";;
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

echo -e "Enter"
echo -e "[1] for LEMP"
echo -e "[2] for LAMP"
echo -e "OR Type exit To Quit"

while true; do

    read -p "Option:: " yn
    case $yn in
        [1]* ) Lemp; break;;
        [2]* ) Lamp; break;;
		[exitEXITExit]* ) exit;;
        * ) echo -e "Please answer from options Available \n";;
	esac
done



while true; do
    read -p "Do You Need A Browser...?" yn
    case $yn in
        [Yy]* ) browser; break;;
        [Nn]* ) break;;
        * ) echo -e "Please answer yes or no.";;
    esac
done


while true; do
    read -p "Do You Need A IDE...?" yn
    case $yn in
        [Yy]* ) ide; break;;
        [Nn]* ) break;;
        * ) echo -e "Please answer yes or no.";;
    esac
done





while true; do
    read -p "Have You Configured Your Development Enviornment And Ready To  Apply Settings..?" yn
    case $yn in
        [Yy]* ) restart; break;;
        [Nn]* ) exit;;
        * ) echo -e "Please answer yes or no.";;
    esac
done

