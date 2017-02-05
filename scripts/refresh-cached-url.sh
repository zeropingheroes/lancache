#!/bin/bash

if [[ $# -eq 0 ]] ; then
    echo ''
    echo 'Usage: refresh-cached-url.sh [url] [range]'
    echo ''
    echo 'Example:'
    echo ''
    echo 'refresh-cached-url.sh "http://origin-a.akamaihd.net/eamaster/s/shift/b____553.zip?sauth=112321235_13bc59b3ec0ffdfdabc9d53e583f6c9" "bytes=5306843136-5307891711"'
    echo ''
    exit 0
fi

if [[ -n "$2" ]]
then
	curl --header "Range: $2" --head "$1&nocache=1"
else
	curl --head "$1&nocache=1"
fi