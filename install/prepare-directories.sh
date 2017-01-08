#!/bin/bash
set -e # abort script if there is an error

PATH_CACHE_DATA="/srv/cache/data"
PATH_NGINX_CONFIG="/etc/nginx"
WWW_USER="www-data"

mkdir -p $PATH_CACHE_DATA
chown -R $WWW_USER:$WWW_USER $PATH_CACHE_DATA

chown -R $WWW_USER:$WWW_USER $PATH_NGINX_CONFIG 
