#!/bin/bash

# Update db schema
cd /opt/phabricator/app/phabricator
./bin/storage upgrade --force
