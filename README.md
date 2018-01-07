# LANcache
Automatically cache game files and updates at LAN parties using [Nginx](http://nginx.org/) as a reverse proxy.

Forked with thanks from [Lochnair/lancache](https://github.com/Lochnair/lancache)

# Requirements

* Ubuntu 16.04
* Nginx compiled with `slice` and `pcre` modules
* [A DNS server to redirect clients to the cache](https://github.com/zeropingheroes/lancache-dns)
* [sniproxy](https://github.com/zeropingheroes/lancache-sniproxy) to serve HTTPS requests

# Installation

1. `sudo -i`

2. `git clone https://github.com/zeropingheroes/lancache.git /etc/nginx`

3. `cd /etc/nginx`

4. `cp .env.example .env`

5. `nano .env`

6. `./prepare-configs.sh`

7. `systemctl restart nginx`

# Enabling & Disabling Caches

Simply create and remove symlinks from `caches-available/` to `caches-enabled`

- `ln -s /etc/nginx/caches-available/cache-name.conf /etc/nginx/caches-enabled/cache-name.conf`

- `rm /etc/nginx/caches-enabled/cache-name.conf`

# Clearing Cache

To clear the cache, run:

`/etc/nginx/scripts/clear-cache.sh`

# Known Issues

## Cache Corruption
In the very unlikely event that the cache stores and serves up a corrupted file, only some download clients handle this helpfully for us:

* **Blizzard** - **OK** - Re-requests the file with headers `Pragma: no-cache` and `Cache-control: no-cache` which causes Nginx to bypass the cache and request a fresh copy of the file from upstream 
* **Steam** - **Not OK** - Steam will re-request a corrupt file from the cache over and over, but will never send `Pragma: no-cache` and `Cache-control: no-cache` headers. This causes the game download to never complete
* **Origin** - **Not OK** - All requests are sent with `Pragma: no-cache` and `Cache-control: no-cache` and we ignore these or nothing would be cached. If a file is corrupt in the cache there is no mechanism for the Origin client to request Nginx fetches a fresh copy of the file from upstream
* **Windows Update** - **Untested**
* **Riot** - **Untested**

# Contributing

Please submit pull requests to useful changes and enhancements.

Recommended reading: [Nginx's Caching blog post](https://www.nginx.com/blog/nginx-high-performance-caching/)
