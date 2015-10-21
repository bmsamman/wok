#!/bin/bash
dsniff -m -i $VIFACE -d -w dsniff$(date +%F-%H%M).log &

