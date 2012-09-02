#!/bin/bash -   
#title          :mysql-dbs-restore.sh
#description    :This script will Script to restore multiple DB to mysql from .sql files;
#		 asumes the dbname is the name of the .sql file
#author         :Sergio Aguilar
#date           :20120518
#version        :0.0.1  
#usage          :./mysql-dbs-restore.sh
#notes          :       
#bash_version   :4.2.24(1)-release
#============================================================================

# Config Variables:
USER="root"
HOST="localhost"

# Read mysql root password:
echo -n "Type mysql root password: "
read -s PASS
echo ""

# Extract files from .gz archives:
function gzip_extract {

  for filename in *.gz
    do
      echo "extracting $filename"
      gzip -d $filename
    done
}

# Look for sql.gz files:
if [ "$(ls -A *.sql.gz 2> /dev/null)" ]  ; then
  echo "sql.gz files found extracting..."
  gzip_extract
else
  echo "No sql.gz files found"
fi

# Exit when folder doesn't have .sql files:
if [ "$(ls -A *.sql 2> /dev/null)" == 0 ]; then
  echo "No *.sql files found"
  exit 0
fi

# Get all database list first
DBS="$(mysql -u $USER -h $HOST -p$PASS -Bse 'show databases')"

echo "These are the current existing Databases:"
echo $DBS

# Ignore list, won't restore the following list of DB:
IGGY="test information_schema mysql"


# Restore DBs:
for filename in *.sql
do
  dbname=${filename%.sql}
  
  skipdb=-1
  if [ "$IGGY" != "" ]; then
    for ignore in $IGGY
    do
        [ "$dbname" == "$ignore" ] && skipdb=1 || :
        
    done
  fi      

  # If not in ignore list, restore:
  if [ "$skipdb" == "-1" ] ; then
  
    skip_create=-1
    for existing in $DBS
    do      
      #echo "Checking database: $dbname to $existing"
      [ "$dbname" == "$existing" ] && skip_create=1 || :
    done
  
    if [ "$skip_create" ==  "1" ] ; then 
      echo "Database: $dbname already exist, skiping create"
    else
      echo "Creating DB: $dbname"
      mysqladmin create $dbname -u $USER -p$PASS
    fi
    
    echo "Importing DB: $dbname from $filename"
    mysql $dbname < $filename -u $USER -p$PASS
  fi    
done
