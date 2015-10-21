#!/bin/bash
tar -pczf safekeeping.tar.gz $DIR_PATH 
gpg -c safekeeping.tar.gz
