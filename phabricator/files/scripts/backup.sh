#!/bin/bash
#set -e
#set -x

cd /opt/phabricator/app/phabricator
ROOT=`pwd` # You can hard-code the path here instead.
GITROOT=/var/repo
BACKUPROOT=/backups
DATESTRING=`date +%s`
BACKUPFOLDER=$BACKUPROOT/$DATESTRING

mkdir --parent $BACKUPFOLDER

echo Starting phabricator backup to $BACKUPFOLDER


echo Backing up database
$ROOT/phabricator/bin/storage dump | gzip > $BACKUPFOLDER/database.sql.gz

echo Backing up git
tar czvf $BACKUPFOLDER/git.tgz $GITROOT

ls -alsh $BACKUPFOLDER

echo Job done.
