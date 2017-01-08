#!/bin/bash

echo "Copying Nginx systemd service configuration into place"
cp systemd/nginx.service /lib/systemd/system/nginx.service

echo "Reloaing systemd"
/bin/systemctl daemon-reload

echo "Installing Nginx service to start at boot"
/bin/systemctl enable nginx
