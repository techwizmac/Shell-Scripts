#!/bin/sh 
#
# ===================================================================
# CMS information extraction
# Author: techwizmac, 2016
# ===================================================================
#
set -x  # debugging starts

# Empty result file in case anything was left from prior run
truncate -s 0 CMS-Report

# extract header info from each website-list using WhatWeb utility
for item in $(ls ./WEBSITES/);
  do whatweb -a3 -v -i ./WEBSITES/$item >>results-$item; # dump extraction on temp file
  if [ "$item" != 'Drupal2' ]
  then 
   cat results-$item|grep -e report -e "\s*\+IP" -e "\s*\+String \+:\+.\+$item\+."|tr -d '\n' >>CMS-Report # dump CMS version info only on file 'CMS-Report'
  fi
  if [ "$item" = 'Drupal2' ]
  then
   cat results-$item|grep -e report -e "\s*\+IP" -e "\s*\+(from MD5 sums)"|tr -d '\n' >>CMS-Report # dump CMS version info only on file 'CMS-Report'
  fi
done

#Beautify text
sed -i 's/WhatWeb /\n/g' CMS-Report
sed -i 's/IP        : / IP:/g' CMS-Report
sed -i 's/Version      : / Drupal Ver.:/g' CMS-Report
sed -i 's/String       : /MetaGenerator: /g' CMS-Report
sed -i ':a;N;$!ba;s/\n/  /g' CMS-Report
sed -i 's/report for /\n/g' CMS-Report
sed -i 's/Powered by Visual Composer - drag and drop page builder for WordPress.,//g' CMS-Report
sed -i 's/- Open Source Content Management//g' CMS-Report

# Change text colour for outdated versions
sed -i ''/'WordPress 3.5.1'/s//`printf "\033[31mWordPress_3.5.1\033[0m"`/'' CMS-Report
sed -i ''/'WordPress 3.8.3'/s//`printf "\033[31mWordPress_3.8.3\033[0m"`/'' CMS-Report
sed -i ''/'WordPress 3.9.1'/s//`printf "\033[31mWordPress_3.9.1\033[0m"`/'' CMS-Report
sed -i ''/'WordPress 3.2.1'/s//`printf "\033[31mWordPress_3.2.1\033[0m"`/'' CMS-Report
sed -i ''/'WordPress 4.2.1'/s//`printf "\033[31mWordPress_4.2.1\033[0m"`/'' CMS-Report
sed -i ''/'WordPress 4.2.4'/s//`printf "\033[31mWordPress_4.2.4\033[0m"`/'' CMS-Report
sed -i ''/'WordPress 4.5.1'/s//`printf "\033[31mWordPress_4.5.1\033[0m"`/'' CMS-Report
sed -i ''/'WordPress 3.8.4'/s//`printf "\033[31mWordPress_3.8.4\033[0m"`/'' CMS-Report
sed -i ''/'WordPress 4.3.1'/s//`printf "\033[31mWordPress_4.3.1\033[0m"`/'' CMS-Report
sed -i ''/'WordPress 4.1.1'/s//`printf "\033[31mWordPress_4.1.1\033[0m"`/'' CMS-Report
sed -i ''/'WordPress 4.4.4'/s//`printf "\033[31mWordPress_4.1.1\033[0m"`/'' CMS-Report
sed -i ''/'WordPress 4.3.5'/s//`printf "\033[31mWordPress_4.3.5\033[0m"`/'' CMS-Report
sed -i ''/'WordPress 4.3.6'/s//`printf "\033[31mWordPress_4.3.6\033[0m"`/'' CMS-Report
sed -i ''/'WordPress 3.5.2'/s//`printf "\033[31mWordPress_3.5.2\033[0m"`/'' CMS-Report
sed -i ''/'WordPress 4.4.5'/s//`printf "\033[31mWordPress_4.4.5\033[0m"`/'' CMS-Report
sed -i ''/'WordPress 4.4.2'/s//`printf "\033[31mWordPress_4.4.2\033[0m"`/'' CMS-Report
sed -i ''/'WordPress 3.1.2'/s//`printf "\033[31mWordPress_3.1.2\033[0m"`/'' CMS-Report
sed -i ''/'Joomla! 1.5'/s//`printf "\033[31mJoomla!_1.5\033[0m"`/'' CMS-Report

# Remove temporary files
for item in $(ls results-*);
  do rm $item;
done
set +x  # debugging ends
# Done

