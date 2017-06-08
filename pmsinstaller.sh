#!/bin/bash

RED='\033[0;41;30m'
STD='\033[0;0;39m'

pause(){
  read -p "Press [Enter] key to continue..." fackEnterKey
}
pausemanual(){
  read -p "Press [Enter] to return to menu..." fackEnterKey
}

install(){
	clear
	echo -e "\e[1mUpgrading distribution..${STD}"; sudo apt-get update && sudo apt-get upgrade -y ; echo -e "\e[32m.. Done!${STD}"
	echo -e "\e[1mInstalling HTTPS transport package.. ${STD}"; sudo apt-get install apt-transport-https -y --force-yes;
	echo -e "\e[1mInstalling authentication key.. ${STD}"wget -O - https://dev2day.de/pms/dev2day-pms.gpg.key  | sudo apt-key add -; echo -e "\e[32m.. Done!${STD}"
	echo -e "\e[1mAdding repository.. ${STD}";echo "deb https://dev2day.de/pms/ jessie main" | sudo tee /etc/apt/sources.list.d/pms.list "\e[32m.. Done!${STD}"
	echo -e "\e[1mUpdating repo list.. ${STD}"; sudo apt-get update; echo -e "\e[32m.. Done!${STD}"
	echo -e "\e[1mInstalling Plex Media Server.. ${STD}";sudo apt-get install -t jessie plexmediaserver -y --force-yes; echo -e "\e[32m.. Done!${STD}"
	pause
        
}

startservice(){
	clear
	echo -e "\e[1mStarting PMS Service.. ${STD}"; sudo service plexmediaserver start; echo -e "\e[32m.. Done!${STD}"
	pause
}

stopservice(){
	clear
	echo -e "\e[1mStopping PMS Service.. ${STD}"; sudo service plexmediaserver stop; echo -e "\e[32m.. Done!${STD}"
	pause
}

restartservice(){
	clear
	echo -e "\e[1mRestarting PMS Service.. ${STD}"; sudo service plexmediaserver restart; echo -e "\e[32m.. Done!${STD}"
	pause
}

readmanual(){
clear
echo "Author: Joey Kheireddine
Git : @joeykhd
_______________________

PLEX MEDIA SERVER INSTALLER

This bash driven script will install Plex Media Server for you.
It is meant to be used on a Raspberry Pi 3 running Raspbian.

This will complete the correct install procedure for you so you wont
have to do it manually.

If you have any problems or any questions dont hesitate to contact me
through Github.
_______________________
"
pausemanual
}

show_menus() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~"	
	echo -e "\e[1mPLEX SERVER INSTALLER ${STD}"
	echo "~~~~~~~~~~~~~~~~~~~~~"
	echo -e "\e[1mauthor: ${STD} Joey Kheireddine"
	echo -e "\e[1mgithub : ${STD} github.com/joeykhd

This will install Plex Media Server on Raspbian.
"
	echo -e "\e[92m[1]${STD} Install Plex Media Server"
	echo -e "\e[92m[2]${STD} Read Manual"
	echo ""
	echo "Service Start/Stop/Restart | * only works if installed"
	echo ""
	echo -e "\e[92m[3]${STD} Start PMS Service"
	echo -e "\e[92m[4]${STD} Stop PMS Service"
	echo -e "\e[92m[5]${STD} Restart PMS Service"
	echo ""
	echo -e "\e[92m[6]${STD} Exit"
	echo ""
}
read_options(){
	local choice
	read -p "Enter choice [ 1 - 6] " choice
	case $choice in
		1) install ;;
		2) readmanual ;;
		3) startservice;;		
		4) stopservice;;
		5) restartservice;;
		6) exit 0;;
		
	esac
}
 
trap '' SIGINT SIGQUIT SIGTSTP

while true
do
 
	show_menus
	read_options
done
