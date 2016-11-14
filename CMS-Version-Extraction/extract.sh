#!/bin/sh 
#
# ===================================================================
# CMS information extraction
# Author: techwizmac, 2016
# ===================================================================
#

# set -x  # debugging starts

# Empty result file in case anything was left from prior run
truncate -s 0 CMS-Report-Txt CMS-Report-Web

# Decide on the type of report
clear
Menu(){
    NORMAL=`echo "\033[m"` #white
    MENU=`echo "\033[36m"` #Blue
    NUMBER=`echo "\033[33m"` #yellow
    ENTER_LINE=`echo "\033[33m"` #yellow
    echo "${MENU}**********************************${NORMAL}"
    echo "${MENU}${NUMBER}1 ${MENU}--> Regular Flat Text Report  ${NORMAL}"
    echo "${MENU}${NUMBER}2 ${MENU}--> HTML Based Report ${NORMAL}"
    echo "${MENU}${NUMBER}3 ${MENU}--> Exit ${NORMAL}"
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
 1) clear;
 Selection "Generating Flat Text Based Report..\n\n";
# Insert Headings
echo 'CMS Websites [Organization-Name]\n' >>CMS-Report-Txt
echo $(date) >>CMS-Report-Txt
echo '\nBy-Weekly Report of CMS Based Websites\n' >>CMS-Report-Txt
echo '\033[31mred\033[0m=outdated (see list of Vulns per version below list)' >>CMS-Report-Txt
echo '\033[33mgreen\033[0m=old but still supported\n' >>CMS-Report-Txt

 
# extract header info from each website-list using WhatWeb utility
for item in $(ls ./WEBSITES/);
  do whatweb -a3 -v -i ./WEBSITES/$item >>results-$item; # dump extraction on temp file
  echo '\n\n'$item|awk '{print toupper($0)}'>>CMS-Report-Txt
  if [ "$item" != 'Drupal2' ]
  then 
   cat results-$item|grep -e report -e "\s*\+IP" -e "\s*\+String \+:\+.\+$item\+."|tr -d '\n' >>CMS-Report-Txt # dump CMS version info only on Report file
  fi
  if [ "$item" = 'Drupal2' ]
  then
   cat results-$item|grep -e report -e "\s*\+IP" -e "\s*\+(from MD5 sums)"|tr -d '\n' >>CMS-Report-Txt # dump CMS version info only on Report file
  fi
done

#Beautify text
sed -i 's/WhatWeb report for /\n/g' CMS-Report-Txt
sed -i 's/IP        : / IP:/g' CMS-Report-Txt
sed -i 's/Version      : / MetaGenerator: Drupal /g' CMS-Report-Txt
sed -i 's/String       : /MetaGenerator: /g' CMS-Report-Txt
sed -i 's/Powered by Visual Composer - drag and drop page builder for WordPress.,//g' CMS-Report-Txt
sed -i 's/- Open Source Content Management//g' CMS-Report-Txt
sed -i 's/drag and drop page//g' CMS-Report-Txt
sed -i 's/Powered by //g' CMS-Report-Txt
sed -i 's/Multi-Purpose, Responsive, Parallax, Mobile-Friendly Slider//g' CMS-Report-Txt
sed -i 's/MetaGenerator: WordPress,WordPress,/ /g' CMS-Report-Txt

# Change text colour for outdated versions
sed -i ''/'WordPress 3.1.2'/s//`printf "\033[31mWordPress_3.1.2\033[0m"`/'' CMS-Report-Txt
sed -i ''/'WordPress 3.2.1'/s//`printf "\033[31mWordPress_3.2.1\033[0m"`/'' CMS-Report-Txt
sed -i ''/'WordPress 3.5.1'/s//`printf "\033[31mWordPress_3.5.1\033[0m"`/'' CMS-Report-Txt
sed -i ''/'WordPress 3.5.2'/s//`printf "\033[31mWordPress_3.5.2\033[0m"`/'' CMS-Report-Txt
sed -i ''/'WordPress 3.8.3'/s//`printf "\033[31mWordPress_3.8.3\033[0m"`/'' CMS-Report-Txt
sed -i ''/'WordPress 3.8.4'/s//`printf "\033[31mWordPress_3.8.4\033[0m"`/'' CMS-Report-Txt
sed -i ''/'WordPress 3.9.1'/s//`printf "\033[31mWordPress_3.9.1\033[0m"`/'' CMS-Report-Txt
sed -i ''/'WordPress 4.1.1'/s//`printf "\033[31mWordPress_4.1.1\033[0m"`/'' CMS-Report-Txt
sed -i ''/'WordPress 4.2.1'/s//`printf "\033[31mWordPress_4.2.1\033[0m"`/'' CMS-Report-Txt
sed -i ''/'WordPress 4.2.4'/s//`printf "\033[31mWordPress_4.2.4\033[0m"`/'' CMS-Report-Txt
sed -i ''/'WordPress 4.3.1'/s//`printf "\033[31mWordPress_4.3.1\033[0m"`/'' CMS-Report-Txt
sed -i ''/'WordPress 4.3.5'/s//`printf "\033[31mWordPress_4.3.5\033[0m"`/'' CMS-Report-Txt
sed -i ''/'WordPress 4.3.6'/s//`printf "\033[31mWordPress_4.3.6\033[0m"`/'' CMS-Report-Txt
sed -i ''/'WordPress 4.4.2'/s//`printf "\033[31mWordPress_4.4.2\033[0m"`/'' CMS-Report-Txt
sed -i ''/'WordPress 4.4.4'/s//`printf "\033[31mWordPress_4.4.4\033[0m"`/'' CMS-Report-Txt
sed -i ''/'WordPress 4.4.5'/s//`printf "\033[31mWordPress_4.4.5\033[0m"`/'' CMS-Report-Txt
sed -i ''/'WordPress 4.5.1'/s//`printf "\033[31mWordPress_4.5.1\033[0m"`/'' CMS-Report-Txt
sed -i ''/'WordPress 4.5.2'/s//`printf "\033[33mWordPress_4.5.2\033[0m"`/'' CMS-Report-Txt
sed -i ''/'WordPress 4.5.3'/s//`printf "\033[33mWordPress_4.5.3\033[0m"`/'' CMS-Report-Txt
sed -i ''/'WordPress 4.5.4'/s//`printf "\033[33mWordPress_4.5.4\033[0m"`/'' CMS-Report-Txt
sed -i ''/'Joomla! 1.5'/s//`printf "\033[31mJoomla!_1.5\033[0m"`/'' CMS-Report-Txt
sed -i ''/'Joomla! 1.7'/s//`printf "\033[31mJoomla!_1.7\033[0m"`/'' CMS-Report-Txt
sed -i ''/'Drupal 5.22'/s//`printf "\033[33mDrupal_5.22\033[0m"`/'' CMS-Report-Txt
sed -i ''/'Drupal 6.29'/s//`printf "\033[33mDrupal_6.29\033[0m"`/'' CMS-Report-Txt

# Remove temporary files
for item in $(ls results-*);
 do rm $item;
done

 clear
 Menu;
 ;;
 2) clear;
Selection "Generating HTML Based Report..\n\n";
# Insert HTML Headings
echo '<html>\n<head>\n<title>CMS Websites  [Organization-Name]</title>\n' >>CMS-Report-Web
echo '<style>\ndiv.boxed {\nborder: 3px solid red;\nwidth: 900px;\nmargin-left: left;\nmargin-right: auto;\nbackground-color: lightgrey;}\n</style>\n</head>\n<body>\n<p>' >>CMS-Report-Web
echo '<div class="boxed">\n<h4>'$(date)'</h4>' >>CMS-Report-Web
echo "<h2>By-Weekly Report of CMS Based Websites</h2>" >>CMS-Report-Web
echo "<h3><font color="red">red</font>=outdated (see list of Vulns per version below list)<br>" >>CMS-Report-Web
echo "<font color="yellow">yellow</font>=old but still supported</h3>\n<br><br>" >>CMS-Report-Web


# extract header info from each website-list using WhatWeb utility
for item in $(ls ./WEBSITES/);
  do whatweb -a3 -v -i ./WEBSITES/$item >>results-$item; # dump extraction on temp file
  echo '<h3><span style="text-transform: uppercase">'$item'</span></h3>\n<table border="1">\n<tr>' >>CMS-Report-Web
  if [ "$item" != 'Drupal2' ]
  then 
   cat results-$item|grep -e report -e "\s*\+IP" -e "\s*\+String \+:\+.\+$item\+."|tr -d '\n' >>CMS-Report-Web # dump CMS version info only on Report file
  fi
  if [ "$item" = 'Drupal2' ]
  then
     cat results-$item|grep -e report -e "\s*\+IP" -e "\s*\+(from MD5 sums)"|tr -d '\n' >>CMS-Report-Web # dump CMS version info only on Report file
  fi
  echo '\n</table>\n' >>CMS-Report-Web
done

# Change text colour for outdated versions
sed -i 's/WordPress 3\.1\.2/<font color="red">WordPress 3\.1\.2<\/font>/g' CMS-Report-Web
sed -i 's/WordPress 3\.2\.1/<font color="red">WordPress 3\.2\.1<\/font>/g' CMS-Report-Web
sed -i 's/WordPress 3\.5\.1/<font color="red">WordPress 3\.5\.1<\/font>/g' CMS-Report-Web
sed -i 's/WordPress 3\.5\.2/<font color="red">WordPress 3\.5\.2<\/font>/g' CMS-Report-Web
sed -i 's/WordPress 3\.8\.3/<font color="red">WordPress 3\.8\.3<\/font>/g' CMS-Report-Web
sed -i 's/WordPress 3\.8\.4/<font color="red">WordPress 3\.8\.4<\/font>/g' CMS-Report-Web
sed -i 's/WordPress 3\.9\.1/<font color="red">WordPress 3\.9\.1<\/font>/g' CMS-Report-Web
sed -i 's/WordPress 4\.1\.1/<font color="red">WordPress 4\.1\.1<\/font>/g' CMS-Report-Web
sed -i 's/WordPress 4\.2\.1/<font color="red">WordPress 4\.2\.1<\/font>/g' CMS-Report-Web
sed -i 's/WordPress 4\.2\.4/<font color="red">WordPress 4\.2\.4<\/font>/g' CMS-Report-Web
sed -i 's/WordPress 4\.3\.1/<font color="red">WordPress 4\.3\.1<\/font>/g' CMS-Report-Web
sed -i 's/WordPress 4\.3\.5/<font color="red">WordPress 4\.3\.5<\/font>/g' CMS-Report-Web
sed -i 's/WordPress 4\.3\.6/<font color="red">WordPress 4\.3\.6<\/font>/g' CMS-Report-Web
sed -i 's/WordPress 4\.4\.2/<font color="red">WordPress 4\.4\.2<\/font>/g' CMS-Report-Web
sed -i 's/WordPress 4\.4\.4/<font color="red">WordPress 4\.4\.4<\/font>/g' CMS-Report-Web
sed -i 's/WordPress 4\.4\.5/<font color="red">WordPress 4\.4\.5<\/font>/g' CMS-Report-Web
sed -i 's/WordPress 4\.5\.1/<font color="yellow">WordPress 4\.5\.1<\/font>/g' CMS-Report-Web
sed -i 's/WordPress 4\.5\.2/<font color="yellow">WordPress 4\.5\.2<\/font>/g' CMS-Report-Web
sed -i 's/WordPress 4\.5\.3/<font color="yellow">WordPress 4\.5\.3<\/font>/g' CMS-Report-Web
sed -i 's/WordPress 4\.5\.4/<font color="yellow">WordPress 4\.5\.4<\/font>/g' CMS-Report-Web
sed -i 's/Joomla\! 1\.5/<font color="red">Joomla\! 1\.5<\/font>/g' CMS-Report-Web
sed -i 's/Joomla\! 1\.7/<font color="red">Joomla\! 1\.7<\/font>/g' CMS-Report-Web
sed -i 's/Drupal 5\.22/<font color="red">Drupal 5\.22<\/font>/g' CMS-Report-Web
sed -i 's/Drupal 6\.29/<font color="red">Drupal 6\.29<\/font>/g' CMS-Report-Web

#Beautify text
sed -i 's/WhatWeb report for /\n<td>/g' CMS-Report-Web
sed -i 's/IP        : /<\/td><td>IP:/g' CMS-Report-Web
sed -i 's/Version      : /<\/td><td>MetaGenerator: Drupal /g' CMS-Report-Web
sed -i 's/String       : /<\/td><td>MetaGenerator: /g' CMS-Report-Web
sed -i 's/Powered by Visual Composer - drag and drop page builder for WordPress.,/ /g' CMS-Report-Web
sed -i 's/Powered by //g' CMS-Report-Web
sed -i 's/- Open Source Content Management//g' CMS-Report-Web
sed -i 's/drag and drop page//g' CMS-Report-Web
sed -i 's/Multi-Purpose, Responsive, Parallax, Mobile-Friendly Slider//g' CMS-Report-Web
sed -i 's/MetaGenerator: WordPress,WordPress,/ /g' CMS-Report-Web
sed -i 's/\\[1m\\[34m//g' CMS-Report-Web
sed -i 's/\\[1m\\[32m//g' CMS-Report-Web
sed -i 's/\\[1m\\[36m//g' CMS-Report-Web
sed -i 's/\\[0m/ /g' CMS-Report-Web
sed -i 's/[^>;{}]$/<\/td><\/tr>/g' CMS-Report-Web

# Insert HTML footing
echo '<br><br><b>References:</b><br>' >>CMS-Report-Web
echo '<font size="4">Wordpress: </font><a href="https://codex.wordpress.org/WordPress_Versions">https://codex.wordpress.org/WordPress_Versions</a><br>' >>CMS-Report-Web
echo '<font size="4">Joomla: </font><a href="https://developer.joomla.org/security-centre.html">https://developer.joomla.org/security-centre.html</a><br>' >>CMS-Report-Web
echo '<font size="4">Drupal: </font><a href="https://www.drupal.org/security">https://www.drupal.org/security</a><br>' >>CMS-Report-Web
echo '<font size="4">Plone: </font><a href="https://plone.org/security">https://plone.org/security</a><br>' >>CMS-Report-Web
echo '</div></p>\n' CMS-Report-Web
echo '</body>\n</html>\n' >>CMS-Report-Web

# Remove temporary files
for item in $(ls results-*);
  do rm $item;
done

clear
Menu;
;;

3) clear;
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


