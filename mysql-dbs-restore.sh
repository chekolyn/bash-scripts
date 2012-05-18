#!/bin/bash
# Script to restore multiple DB to mysql from .sql files.
# asumes the dbname is the name of the .sql file

# Read mysql root password:
echo -n "Type mysql root password: "
read -s pass

# Exit when folder doesn't have .sql files:
if [ ! -f *.sql ]
then
  echo "No *.sql files found"
  exit 0
fi

#  all sql files and import them:
for filename in *.sql
  do
   dbname=${filename%.sql}
    echo "Importing DB: $dbname from $filename"
    mysql $dbname < $filename -uroot -p$pass
  done

