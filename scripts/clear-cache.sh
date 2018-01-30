#!/bin/bash

PATH_CACHE="/var/lancache/data"
PATH_LOGS="/var/lancache/logs"

echo "Stopping nginx"
/bin/systemctl stop nginx

echo "Stopping filebeat"
/bin/systemctl stop filebeat

echo "Truncating logs"
rm $PATH_LOGS/*.log

echo "Clearing cache"
rm -r $PATH_CACHE/*

echo "Starting nginx"
/bin/systemctl start nginx

echo "Starting filebeat"
/bin/systemctl start filebeat

echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "IF USING ELK ENSURE ELASTICSEARCH IS ALSO CLEARED"
echo "OR KIBANA VISUALISATIONS WON'T ACCURATELY SHOW"
echo "ALL FILES THAT HAVE BEEN CACHED PREVIOUSLY... "
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

