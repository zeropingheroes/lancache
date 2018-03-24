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

# Removing Specific Items From The Cache

It is desirable to remove items from the cache, in case of corruption, or items being cached that shouldn't have been.

Currently there is no straightforward or reliable way to do this, without paying for [Nginx Plus](https://www.nginx.com/products/nginx/). 

The closest we can get is to **update the cached item from upstream** by using the `proxy_cache_bypass` config option to tell Nginx to re-fetch the item from upstream when it receives the custom request header `"X-Cache-Bypass"`, forcing it to update the item in cache, and serve the updated item to the client. This can be done using the following CURL snippet:

```
$ export ITEM_TO_RE_REQUEST="http://valve123.steamcontent.com/depot/282440/chunk/d6556e1b9f7?l=14&e=1446464&sid=103124340&h=2da3a7ad94cab11ff1e6aac28"
$ curl --verbose --header "X-Cache-Bypass: 1" "$ITEM_TO_RE_REQUEST" > /dev/null
```

`$ITEM_TO_RE_REQUEST` must be set to the full URL, including the original query string, so that Nginx can pass the request on and get a valid response. If Nginx does not get a valid response, the item will not be updated in the cache.

## Problems with this approach

- The item must be re-downloaded from upstream, rather than just being invalidated locally
- The upstream server must respond with a 2xx response code
- If the original request that was cached had a query string with some authentication from the download client, the authentication may have expired, causing the re-request to fail
- Using this method for many items will require getting a big list of URLs, and take a significant amount of time to run
- If the original request was made with a range request, the re-request must use a range request too

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
