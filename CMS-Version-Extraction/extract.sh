#!/bin/sh 
#
# ===================================================================
# CMS information extraction script using an existing list of sites
# Author: techwizmac, 2016
# ===================================================================
#
set -x  # debugging starts
# Empty files prior to processing
for item in $(ls results-*);
 do truncate -s 0 $item;
done
truncate -s 0 CMS-Report
# Generate header information from each website list using WhatWeb utility
for item in $(ls ./WEBSITES/);
  do whatweb -v -i ./WEBSITES/$item >>results-$item;
done
# Extract CMS version info and dump results on a temp file
echo "Wordpress extract..."
cat results-wordpress|grep -e "\s*\+String \+: \+.\+WordPress" -e "\s*\+IP" -e report >>cms-results
echo "Drupal extract..."
cat results-drupal|grep -e "\s*\+String \+: \+.\+Drupal" -e "\s*\+IP" -e report >>cms-results
echo "Joomla extract..."
cat results-joomla|grep -e "\s*\+String \+: \+.\+Joomla" -e "\s*\+IP" -e report >>cms-results
echo "Plone extract..."
cat results-plone|grep -e "\s*\+String \+: \+.\+Zope" -e "\s*\+IP" -e report >>cms-results
echo "Other extract..."
cat results-other|grep -e "\s*\+String \+: \+.\+Other" -e "\s*\+IP" -e report >>cms-results
# Change text colour for outdated versions
cat cms-results|sed ''/3.5.1/s//`printf "\033[31m3.5.1\033[0m"`/'' > cms-results1
cat cms-results1|sed ''/3.8.3/s//`printf "\033[31m3.8.3\033[0m"`/'' > cms-results2
cat cms-results2|sed ''/3.9.1/s//`printf "\033[31m3.9.1\033[0m"`/'' > cms-results3
cat cms-results3|sed ''/3.2.1/s//`printf "\033[31m3.2.1\033[0m"`/'' > cms-results4
cat cms-results4|sed ''/4.2.1/s//`printf "\033[31m4.2.1\033[0m"`/'' > cms-results5
cat cms-results5|sed ''/4.2.4/s//`printf "\033[31m4.2.4\033[0m"`/'' > cms-results6
cat cms-results6|sed ''/4.5.1/s//`printf "\033[31m4.5.1\033[0m"`/'' > cms-results7
cat cms-results7|sed ''/3.8.4/s//`printf "\033[31m3.8.4\033[0m"`/'' > cms-results8
cat cms-results8|sed ''/4.3.1/s//`printf "\033[31m4.3.1\033[0m"`/'' > cms-results9
cat cms-results9|sed ''/4.1.1/s//`printf "\033[31m4.1.1\033[0m"`/'' > cms-results10
cat cms-results10|sed ''/4.4.4/s//`printf "\033[31m4.1.1\033[0m"`/'' > cms-results11
cat cms-results11|sed ''/4.3.5/s//`printf "\033[31m4.3.5\033[0m"`/'' > cms-results12
cat cms-results12|sed ''/3.5.2/s//`printf "\033[31m3.5.2\033[0m"`/'' > cms-results13
cat cms-results13|sed ''/4.4.5/s//`printf "\033[31m4.4.5\033[0m"`/'' > cms-results14
cat cms-results14|sed ''/4.4.2/s//`printf "\033[31m4.4.2\033[0m"`/'' > cms-results15
cat cms-results15|sed ''/3.1.2/s//`printf "\033[31m3.1.2\033[0m"`/'' > cms-results-temp
#cat cms-results11|sed ''/Joomla! 1.5/s//`printf "\033[31mJoomla! 1.5\033[0m"`/'' > cms-results12
sed 's/WhatWeb //g' cms-results-temp >>cms-results-temp1
sed 's/IP        : /IP:/g' cms-results-temp1 >>cms-results-temp2
sed 's/String       : /MetaGenerator:/g' cms-results-temp2 >>cms-results-temp3
sed ':a;N;$!ba;s/\n/  /g' cms-results-temp3 >>cms-results-temp4
sed 's/report for /\n/g' cms-results-temp4 >>cms-results-temp5
sed 's/Powered by Visual Composer - drag and drop page builder for WordPress.,//g' cms-results-temp5 >>cms-results-temp6
sed 's/- Open Source Content Management//g' cms-results-temp6 >>CMS-Report
#Remove intermediate files
for item in $(ls cms-results*);
 do rm $item;
done
set +x  # debugging ends

# Done

