#!/bin/bash


if [[ $EUID -ne 0 ]]; then
   echo "Please Change User To Root" 
   exit 1
fi


apache ()
{
	clear
	echo "Installing Apache2"
	apt-get install apache2
	echo "Apache2 Installation Complete"
	
}
nginx ()
{
	clear
	echo "Installing Nginx..."
	apt-get install nginx
	echo "Nginx.. Installation Complete!!"
	echo "You Can Now Configure Nginx"
}

mariadb ()
{
	clear
	echo "Installing Maria-Db"	
	apt-get install mariadb-server mariadb-client
	echo "Maria-Db Installation Complete"
}

php ()
{
	clear
	echo "Installing PHP Latest Version Avaialble"
	apt-get install php-fpm php-mysql
	echo "Installing Essential PHP Mods"
	apt-get install php7.0-curl
	echo "PHP Installation Complete"
}

mysql ()
{
	clear
	echo "Installing Mysql Server"
	apt-get install mysql-server mysql-client
	echo "Mysql Installation Complete"
}

phpmyadmin ()
{
	clear
	echo "Installing phpmyadmin"
	apt-get install phpmyadmin
	ln -s /usr/share/phpmyadmin/ /var/www/html
}


git ()
{
	clear
	echo "Installing GIT"
	apt-get install git
	echo "GIT Installed..."
}

sublime ()
{
	clear
	echo "Getting Sublime For You.."
	wget -O /tmp/sublime-text_build-3126_amd64.deb https://download.sublimetext.com/sublime-text_build-3126_amd64.deb
	echo "Installing Sublime...."
	dpkg -i /tmp/sublime-text_build-3126_amd64.deb
	apt-get install -f
	echo "Sublime Installed"
}



chrome ()
{
	clear
	echo "Getting Chrome For You"
	wget -O /tmp/google-chrome-stable_current_amd64.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	echo "Installing...."
	dpkg -i /tmp/google-chrome-stable_current_amd64.deb
	apt-get install -f
	echo "Chrome Installed"
}

mozilla ()
{
	clear	
	echo "Getting Firefox For You"
	wget -O /tmp/firefox-54.0b7.tar.bz2 http://ftp.mozilla.org/pub/firefox/releases/54.0b7/linux-x86_64/en-US/firefox-54.0b7.tar.bz2
	echo "Installing...."
	mv /tmp/firefox-54.0b7.tar.bz2 /opt
	tar xvjf firefox-54.0b7.tar.bz2
	ln -s /opt/firefox/firefox /usr/bin/firefox
	echo "Firefox Installed"

}



restart ()
{
service apache2 restart
service nginx restart
service php-fpm restart
service mysql restart
apt autoremove
apt-get clean
reboot
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
	browser
	ide

}

Lamp ()
{
	apache
	database
	php
	phpmyadmin
	git
	browser
	ide
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
        * ) echo "Please answer from options Available \n";;
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
    read -p "Have You Configured Your Development Enviornment And Apply Settings..?" yn
    case $yn in
        [Yy]* ) restart; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

