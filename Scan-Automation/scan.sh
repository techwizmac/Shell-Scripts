#!/bin/sh 
#
# =================================
# Scan Automation
# Author: techwizmac, 2017
# =================================
#

#set -x  # debugging starts

while true; do
    read -p "Clean Report File?" yn
    case $yn in
        [Yy]* ) truncate -s 0 Scan-Report; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

clear
Menu(){
    NORMAL=`echo "\033[m"` #white
    MENU=`echo "\033[36m"` #Blue
    NUMBER=`echo "\033[33m"` #yellow
    ENTER_LINE=`echo "\033[33m"` #yellow
    echo "${MENU}**********************************${NORMAL}"
    echo "${MENU}${NUMBER}1 ${MENU}--> HTTPIE  0.8.0${NORMAL}"
    echo "${MENU}${NUMBER}2 ${MENU}--> WHATWEB ${NORMAL}"
    echo "${MENU}${NUMBER}3 ${MENU}--> WAFW00F 0.9.4 ${NORMAL}"
    echo "${MENU}${NUMBER}4 ${MENU}--> HPING 3 (80 & 443) ${NORMAL}"
    echo "${MENU}${NUMBER}5 ${MENU}--> NMAP 7.40${NORMAL}"
    echo "${MENU}${NUMBER}6 ${MENU}--> NIKTO 2.6${NORMAL}"
    echo "${MENU}${NUMBER}7 ${MENU}--> SSH-AUDIT 1.7.0${NORMAL}"
    echo "${MENU}${NUMBER}8 ${MENU}--> RDP-SEC-CHECK 0.8 Beta${NORMAL}"
    echo "${MENU}${NUMBER}9 ${MENU}--> TESTSSL 2.8 RC1${NORMAL}"
    echo "${MENU}${NUMBER}10 ${MENU}--> SSL SCAN 1.8.2${NORMAL}"
    echo "${MENU}${NUMBER}11 ${MENU}--> OPEN SSL 1.0.1f${NORMAL}"
    echo "${MENU}${NUMBER}12 ${MENU}--> RUN ALL TESTS ${NORMAL}"
    echo "${MENU}${NUMBER}0 ${MENU}--> Exit ${NORMAL}"
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
   http --pretty all --verbose --output Scan-Report $(cat web)
   echo '\n' >>Scan-Report
   echo '\n' >>Scan-Report
# clear
   Menu;
  ;;

# WHATWEB
 2) clear;
   whatweb -a3 -v $(cat web) >>Scan-Report
   echo '\n' >>Scan-Report
   echo '\n' >>Scan-Report
   clear
Menu;
;;

 3) clear;
   wafw00f -v -a --findall $(cat host) >>Scan-Report
   echo '\n' >>Scan-Report
   echo '\n' >>Scan-Report
   clear
Menu;
;;

# HPING 80,443
 4) clear;
   sudo hping3 -8 80,443 -S $(cat web) -V >>Scan-Report
   echo '\n' >>Scan-Report
   echo '\n' >>Scan-Report
   clear
Menu;
;;

#  NMAP
 5) clear;
   sudo nmap -A -T4 -sSV --version-intensity 9 --script banner $(cat host) -Pn -O -vvv -dd >>Scan-Report
   echo '\n' >>Scan-Report
   echo '\n' >>Scan-Report
   clear
Menu;
;;

# NIKTO-216
 6) clear;
   sudo nmap -p 80,443 $(cat host) -oG -|~/Documents/TOOLS/Web-Tools/Nikto216/program/nikto.pl -h - -C all >>Scan-Report
   echo '\n' >>Scan-Report
   echo '\n' >>Scan-Report
# clear
Menu;
;;

# SSH-AUDIT
 7) clear;
   ssh-audit -v $(cat host) >>Scan-Report
   echo '\n' >>Scan-Report
   echo '\n' >>Scan-Report
# clear
Menu;
;;

# RDP-SEC-CHECK
 8) clear;
   rdpcheck $(cat host):3389 >>Scan-Report
   echo '\n' >>Scan-Report
   echo '\n' >>Scan-Report
# clear
Menu;
;;

# TESTSSL
 9) clear;
   testssl $(cat host) >>Scan-Report
   echo '\n' >>Scan-Report
   echo '\n' >>Scan-Report
# clear
Menu;
;;

#  SSLSCAN
 10) clear;
   sslscan $(cat host) >>Scan-Report
   echo '\n' >>Scan-Report
   echo '\n' >>Scan-Report
# clear
Menu;
;;

# OPENSSL
 11) clear;
   openssl s_client -connect $(cat host):443 -showcerts >>Scan-Report-openssl
   echo '\n' >>Scan-Report
   echo '\n' >>Scan-Report
# clear
Menu;
;;

# RUN ALL TESTS
 12) clear;
   http --pretty all --verbose --output Scan-Report $(cat web)
   echo '\n' >>Scan-Report
   echo '\n' >>Scan-Report
   whatweb -a3 -v $(cat web) >>Scan-Report
   echo '\n' >>Scan-Report
   echo '\n' >>Scan-Report
   wafw00f -v -a --findall $(cat web) >>Scan-Report
   echo '\n' >>Scan-Report
   echo '\n' >>Scan-Report
   sudo hping3 -8 80,443 -S $(cat host) -V >>Scan-Report
   echo '\n' >>Scan-Report
   echo '\n' >>Scan-Report
   sudo nmap -A -T4 -sSV --version-intensity 9 --script banner $(cat host) -Pn -O -vvv -dd >>Scan-Report
   echo '\n' >>Scan-Report
   echo '\n' >>Scan-Report
   sudo nmap -p 80,443 $(cat host) -oG -|~/Documents/TOOLS/Web-Tools/Nikto216/program/nikto.pl -h - -C all >>Scan-Report
   echo '\n' >>Scan-Report
   echo '\n' >>Scan-Report
   ssh-audit -v $(cat host) >>Scan-Report
   echo '\n' >>Scan-Report
   echo '\n' >>Scan-Report
   rdpcheck $(cat host):3389 >>Scan-Report
   echo '\n' >>Scan-Report
   echo '\n' >>Scan-Report
   testssl $(cat host) >>Scan-Report
   echo '\n' >>Scan-Report
   echo '\n' >>Scan-Report
   sslscan $(cat host) >>Scan-Report
   echo '\n' >>Scan-Report
   echo '\n' >>Scan-Report
   openssl s_client -connect $(cat host):443 -showcerts >>Scan-Report-openssl
   echo '\n' >>Scan-Report
   echo '\n' >>Scan-Report
# clear
Menu;
;;

0) clear;
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

