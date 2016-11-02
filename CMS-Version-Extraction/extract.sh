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

 and
# extract header info from each website-list using WhatWeb utility
for item in $(ls ./WEBSITES/);
  do whatweb -v -i ./WEBSITES/$item >>results-$item; # dump extraction on temp file
  cat results-$item|grep -e "\s*\+String \+: \+.\+$item" -e "\s*\+IP" -e report >>CMS-Report # dump CMS version info only on file 'CMS-Report'
done

#Beautify text
sed -i 's/WhatWeb //' CMS-Report
sed -i 's/IP        : /IP:/' CMS-Report
sed -i 's/String       : /MetaGenerator: /' CMS-Report
sed -i ':a;N;$!ba;s/\n/  /' CMS-Report
sed -i 's/report for /\n/' CMS-Report
sed -i 's/Powered by Visual Composer - drag and drop page builder for WordPress.,//' CMS-Report
sed -i 's/- Open Source Content Management//' CMS-Report

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

