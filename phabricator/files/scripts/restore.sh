#!/bin/bash
#set -e
#set -x

BACKUPPATH=$1
DBFILE=$1/database.sql.gz
GITFILE=$1/git.tgz

echo Restoring Phabricator from $BACKUPPATH

if [ ! -f $DBFILE ]; then
  echo "No database backup found! Giving up"
  exit -1
fi

gunzip --stdout $BACKUPPATH/database.sql.gz | mysql -h db -u root -pphabricator phabricator

if [ -f $GITFILE ]; then
  tar xzvf $GITFILE -C /var/repo/ --strip-components=2
fi
