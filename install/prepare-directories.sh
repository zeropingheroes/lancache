#!/bin/bash
set -e # abort script if there is an error

PATH_CACHE="/var/lancache/cache"
PATH_CONFIG="/etc/nginx"
PATH_LOGS="/var/lancache/logs"
WWW_USER="www-data"

echo "Creating cache data directory: $PATH_CACHE"
mkdir -p $PATH_CACHE
cd $PATH_CACHE
mkdir -p installers tmp

echo "Creating logs directory: $PATH_LOGS"
mkdir -p $PATH_LOGS

echo "Changing owner of directories to $WWW_USER"
chown -R $WWW_USER:$WWW_USER $PATH_CACHE
chown -R $WWW_USER:$WWW_USER $PATH_LOGS
chown -R $WWW_USER:$WWW_USER $PATH_CONFIG
