#!/bin/bash -   
#title          :network-dump.sh
#description    :This script will generate network dump samples
#author         :Sergio Aguilar
#date           :20120518
#version        :0.0.1  
#usage          :./network-dump.sh
#notes          :       
#bash_version   :4.2.24(1)-release
#============================================================================

# Set Variables:
TMP=/tmp/network-dump
NOW=$(date +"%F--%T")
FILE=$TMP/network-$NOW.log

# Make sure folder exists:
if [ ! -d $TMP  ]; then mkdir $TMP ; fi

# Capture network :
tcpdump -n -c 10000 -w $FILE

# Make sure only root access it:
chmod -R 700 $TMP

# Delete old files:
# (Currently set to only 1 week)
find $TMP -name "*.log" -mtime +7 -exec rm {} \;

