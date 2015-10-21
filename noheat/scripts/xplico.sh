#!/bin/bash

# configure apache2
sed -i '/Listen 9876/d' /etc/apache2/ports.conf
echo "Listen 9876" >> /etc/apache2/ports.conf
a2enmod php5
a2enmod rewrite
a2ensite xplico

# set permissions
chown -R www-data:www-data /opt/xplico/

# launch xplico
apache2ctl restart
/etc/init.d/binfmt-support start
sleep 3
/etc/init.d/xplico start

echo '---------------  XPLICO GUI  ------------------'
echo ''
echo 'WARNING: Apache2 server started:'
echo '  You will have to stop it manually.'
echo ''
echo 'XPLICO WEB GUI:'
echo '  http://localhost:9876/'
echo ''
echo '---------------  XPLICO GUI  ------------------'

