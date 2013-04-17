#!/bin/bash -   
#title          :audit-log-back.sh
#description    :Backups audit files into a tar file
#author         :Sergio Aguilar
#date           :2012-04-17
#version        :0.1.1
#usage          :./audit-back.sh
#notes          :       
#bash_version   :4.2.24(1)-release
#============================================================================

LOG_FOLDER=/var/log/audit
NOW=$(date +"%F")
HOST=$(hostname)
FILE=$LOG_FOLDER/audits-$HOST-$NOW.tar.gz

# Delete previous tar files:
find $LOG_FOLDER -name "*.tar.gz" -exec rm {} \;

# First look for old log files:
if [ "$(ls -A *.log.* 2> /dev/null)" ]  ; then
  echo "Old log files found; creating tar..."
  # Find old log files and create tar file
  # it will find logs file older than a day (-mtime +1)
  find $LOG_FOLDER -name "*.log.*" -mtime +1  | xargs tar cvfz $FILE
else
  echo "No old logs files found"
fi

# Find files and delete the files:
find $LOG_FOLDER -name "*.log.*" -mtime +1  -exec rm {} \;
