#!/bin/bash -   
#title          :audit-log-back.sh
#description    :Backups audit files into a tar file
#author         :Sergio Aguilar
#date           :20121119
#version        :0.1    
#usage          :./audit-back.sh
#notes          :       
#bash_version   :4.2.24(1)-release
#============================================================================

LOG_FOLDER=/var/log/audit
NOW=$(date +"%F--%T")
FILE=$LOG_FOLDER/audits-$NOW.tar.gz

# Delete previous tar files:
find $LOG_FOLDER -name "*.tar.gz" -exec rm {} \;

# Find files and create tar file
# it will find logs file older than a day (-mtime +1)
find $LOG_FOLDER -name "*.log.*" -mtime +1  | xargs tar cvfz $FILE

# Find files and delete the files:
find $LOG_FOLDER -name "*.log.*" -mtime +1  -exec rm {} \;
