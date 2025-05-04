# LANcache
Automatically cache game files and updates at LAN parties using [Nginx](http://nginx.org/) as a reverse proxy.

Forked with thanks from [Lochnair/lancache](https://github.com/Lochnair/lancache).

Credit to [lancachenet](https://lancache.net) for all their work on content caching for LANs.

# Requirements

* Ubuntu Server 24.04
* A DNS server to redirect clients to the cache:
  * [zeropingheroes/lancache-dns-unbound](https://github.com/zeropingheroes/lancache-dns-unbound)
  * [lancachenet/lancache-dns](https://github.com/lancachenet/lancache-dns)

# Setup

## Install Nginx
`apt install nginx`

## Install lancache configuration
1. `mv /etc/nginx /etc/nginx.default`
2. `git clone git@github.com:zeorpingheroes/lancache.git /etc/nginx`

## Prepare cache directories
1. `mkdir -p /srv/lancache/logs /srv/lancache/data /srv/lancache/tmp`
2. `chown -r www-data:www-data /srv/lancache`

To use a different directory, find and replace in the config files:

`find /etc/nginx -type f -name "*.conf" -print0 | xargs -0 sed -i'' -e 's|/srv/lancache|/your/path|g'`

## Test the configuration
`nginx -t`

## Start Nginx
`systemctl start nginx`
