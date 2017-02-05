#!/bin/bash

echo "Enter in URL (plus query string) that should be refreshed from upstream:"

read URL

curl --head "$URL&nocache=1"