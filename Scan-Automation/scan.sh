#!/bin/sh 
#
# =================================
# Scan Automation
# Author: techwizmac, 2017
# =================================
#

#set -x  # debugging starts

truncate -s 0 Scan-Report

clear
Menu(){
    NORMAL=`echo "\033[m"` #white
    MENU=`echo "\033[36m"` #Blue
    NUMBER=`echo "\033[33m"` #yellow
    ENTER_LINE=`echo "\033[33m"` #yellow
    echo "${MENU}**********************************${NORMAL}"
    echo "${MENU}${NUMBER}1 ${MENU}--> HTTPIE  ${NORMAL}"
    echo "${MENU}${NUMBER}2 ${MENU}--> WHATWEB ${NORMAL}"
    echo "${MENU}${NUMBER}3 ${MENU}--> HPING 80 & 443 ${NORMAL}"
    echo "${MENU}${NUMBER}4 ${MENU}--> NMAP ${NORMAL}"
    echo "${MENU}${NUMBER}5 ${MENU}--> NIKTO ${NORMAL}"
    echo "${MENU}${NUMBER}6 ${MENU}--> SSH-AUDIT ${NORMAL}"
    echo "${MENU}${NUMBER}7 ${MENU}--> RDP-SEC-CHECK ${NORMAL}"
    echo "${MENU}${NUMBER}8 ${MENU}--> TESTSSL ${NORMAL}"
    echo "${MENU}${NUMBER}9 ${MENU}--> Exit ${NORMAL}"

    echo "${MENU}**********************************${NORMAL}"
    echo "${ENTER_LINE}Select a menu option and enter"
    read opt
}

Selection(){
   COLOR='\033[01;31m' # bold red
   RESET='\033[00;00m' # normal white
   MESSAGE=${@:-"${RESET}Error: No message passed"}
   echo "${COLOR}${MESSAGE}${RESET}"
}
Menu
clear
while [ opt != '' ]
 do
 if [[ $opt = ""]]; then 
   exit;
 else
 case $opt in

#  HTTPIE
 1) clear;
   http --pretty all --verbose --output Scan-Report $(cat host)
   echo '\n' >>Scan-Report
   echo '\n' >>Scan-Report
# clear
   Menu;
  ;;

# WHATWEB
 2) clear;
   whatweb -a3 -v -i $(cat host) >>Scan-Report
   echo '\n' >>Scan-Report
   echo '\n' >>Scan-Report
   clear
Menu;
;;

# HPING 80,443
 3) clear;
   sudo hping3 -8 80,443 -S $(cat host) -V >>Scan-Report
   echo '\n' >>Scan-Report
   echo '\n' >>Scan-Report
   clear
Menu;
;;

#  NMAP
 4) clear;
   sudo nmap -A -T4 -sSV --version-intensity 9 --script banner $(cat host) -Pn -O -vvv -dd >>Scan-Report
   echo '\n' >>Scan-Report
   echo '\n' >>Scan-Report
   clear
Menu;
;;

# NIKTO-216
 5) clear;
   sudo nmap -p 80,443 $(cat host) -oG -|~/Documents/TOOLS/Web-Tools/Nikto216/program/nikto.pl -h - -C all >>Scan-Report
   echo '\n' >>Scan-Report
   echo '\n' >>Scan-Report
# clear
Menu;
;;

# SSH-AUDIT
 6) clear;
   ssh-audit -v $(cat host) >>Scan-Report
   echo '\n' >>Scan-Report
   echo '\n' >>Scan-Report
# clear
Menu;
;;

# RDP-SEC-CHECK
 7) clear;
   rdpcheck $(cat host):3389 >>Scan-Report
   echo '\n' >>Scan-Report
   echo '\n' >>Scan-Report
# clear
Menu;
;;

# RDP-SEC-CHECK
 8) clear;
   testssl $(cat host) >>Scan-Report
   echo '\n' >>Scan-Report
   echo '\n' >>Scan-Report
# clear
Menu;
;;

9) clear;
 Selection "Exit";
 exit;
 ;;
 x)exit;
 ;;
 \n)exit;
 ;;
 *)clear;
 Selection "Pick an option from the menu";
 Menu;
 ;;
esac
fi
done

# set +x  # debugging ends

