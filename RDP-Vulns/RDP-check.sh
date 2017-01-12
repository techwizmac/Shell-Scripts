#!/bin/bash

set -x  # debug

truncate -s 0 rdp-vuln-details report-rdp

while read IP; do
   LOOKUP_RES=$(nslookup $IP | sed -n 's/.*arpa.*name = \(.*\)/\1/p')
   echo -e "$IP\t===>>\t$LOOKUP_RES" >>rdp-vuln-details
   rdpcheck $IP >>rdp-vuln-details;
done < host-list

cat rdp-vuln-details| grep -e "has issue" -e "===>>" >>report-rdp
sed -i 's/\=\=\=\>\>/\n/g' report-rdp

