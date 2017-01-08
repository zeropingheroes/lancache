#!/bin/bash
set -e # abort script if there is an error

PATH_CACHE_DATA="/srv/cache/data"

mkdir -p $PATH_CACHE_DATA
chown -R www-data:www-data $PATH_CACHE_DATA

