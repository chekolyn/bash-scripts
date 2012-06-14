#!/bin/bash -   
#title          :ch-atime.sh
#description    :Will change access time of multiple files
#author         :Sergio Aguilar
#date           :20120613
#version        :0.1    
#usage          :./ch-atime.sh
#notes          :       
#bash_version   :4.2.24(1)-release
#============================================================================

echo "Enter extention of file you want to change:"
read EXT

#Get current directory:
DIR=$(pwd)
echo $DIR

for file in $DIR/*.$EXT
do
  #Get the modify time from the same file:
  TIME=$(stat -c%y ${file})
  echo "Changing $file"
  stat $file
  
  #Changing access time to modify time (created)
  touch $file -a -d "$TIME"
  stat $file
done
