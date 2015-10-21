ifconfig $VIFACE up
ifconfig $VIFACE $GW_IP netmask 255.255.255.0
ifconfig $VIFACE mtu 1400
