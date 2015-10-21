#!/bin/bash
echo "1" > /proc/sys/net/ipv4/ip_forward
iptables -P FORWARD ACCEPT
iptables -t nat -A POSTROUTING -o $IFACE -j MASQUERADE

