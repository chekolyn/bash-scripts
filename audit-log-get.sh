#!/bin/bash -   
#title          :audit-log-get.sh
#description    :Will retrive audit tar files
#author         :Sergio Aguilar
#date           :20130417
#version        :0.1.0  
#usage          :./audit-log-get.sh
#notes          :       
#bash_version   :4.2.25(1)-release
#============================================================================

LOG_FOLDER=/var/log/audit
LOCAL_DIR=/backups/auditlogs
HOSTS=('host1' 'host2')

for host in ${HOSTS[@]}
do
  if [ ! -d "$LOCAL_DIR/$host" ]; then
    # Create directory if it doesnt exist:
    echo "$LOCAL_DIR/$host folder doesnt exist; creating..."
    mkdir -P  "$LOCAL_DIR/$host"
  fi
  scp $host:$LOG_FOLDER/*.tar.gz $LOCAL_DESTINATION/$host
  
done
