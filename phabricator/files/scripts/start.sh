#!/bin/bash
mkdir /var/tmp/phd && \
chown -R www-data /tmp/phabricator
chown -R www-data /tmp/phabricator-sessions
chown -R phd.phd /var/tmp/phd && \

cd /opt/phabricator/app/phabricator
./bin/config set phabricator.base-uri $PHABRICATOR_BASE_URL

echo Waiting for database to launch...
attempts=0
maxAttempts=5
until [ $attempts -ge $maxAttempts ]
do
    mysql -u phabricator -pphabricator -h db --connect-timeout=1 -e ";" && break
    attempts=$[$attempts+1]
    if [ $attempts -ge $maxAttempts ]
    then
        echo Giving up.
        exit -1
    fi
    sleep 5
done



./bin/storage upgrade --force

service php7.2-fpm start
service nginx start
./bin/phd start

tail -f --retry /var/log/phabricator/*.log /var/log/php7.2-fpm.log
