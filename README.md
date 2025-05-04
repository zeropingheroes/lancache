# LANcache
Automatically cache game files and updates at LAN parties using [Nginx](http://nginx.org/) as a reverse proxy.

Forked with thanks from [Lochnair/lancache](https://github.com/Lochnair/lancache)
Credit to [lancachenet](https://lancache.net) for all their work on content caching for LANs.

# Requirements

* Ubuntu 24.04
* [A DNS server to redirect clients to the cache](https://github.com/lancachenet/lancache-dns)

# Setup

1. `sudo -i`
2. `apt install nginx`
3. `mv /etc/nginx /etc/nginx.default`
4. `git clone git@github.com:zeorpingheroes/lancache.git /etc/nginx`
5. `systemctl start nginx`

# Enabling & Disabling Caches

Simply create and remove symlinks from `caches-available/` to `caches-enabled`

- `ln -s /etc/nginx/caches-available/cache-name.conf /etc/nginx/caches-enabled/cache-name.conf`

- `rm /etc/nginx/caches-enabled/cache-name.conf`
