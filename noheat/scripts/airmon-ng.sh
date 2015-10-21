#!/bin/bash
ifconfig $WIFACE down
airmon-ng start $WIFACE
ifconfig $WIFACE up
iwconfig $WIFACE chan 6
iwconfig mon0 chan 6

