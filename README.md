# LANcache
Automatically cache game files and updates at LAN parties using [Nginx](http://nginx.org/) as a reverse proxy.

Forked from [Lochnair/lancache](https://github.com/Lochnair/lancache)

# Requirements

* Ubuntu 16.04
* [A DNS server to redirect clients to the cache](https://github.com/zeropingheroes/lancache-dns)
* [sniproxy](https://github.com/zeropingheroes/lancache-sniproxy) to serve HTTPS requests

# Installation

Enter an interative superuser shell:

`sudo -i`

Create the Nginx config directory:

`mkdir /etc/nginx && cd /etc/nginx`

Clone the *zeropingheroes/lancache* repository into it:

`git clone https://github.com/zeropingheroes/lancache.git .`

Make all the scripts in the install directory executable:

`chmod -R +x /etc/nginx/install/`

Compile Nginx from source:

`/etc/nginx/install/compile-nginx.sh`

Prepare directories:

`/etc/nginx/install/prepare-directories.sh`

Install Nginx as a service to start at boot:

`/etc/nginx/install/install-nginx-service.sh`

Start Nginx:

`systemctl start nginx`

# Configuration & Usage

## Maximum Cache Size

To limit how much space the cache data folder can use, edit:

`includes/proxy-cache-paths.conf`

Adjust `max_size=1000g` to fit your needs.

## Enabling/Disabling Caches

### Enabling

`ln -s /etc/nginx/caches-available/cache-name.conf /etc/nginx/caches-enabled/cache-name.conf`

### Disabling

`rm /etc/nginx/caches-enabled/cache-name.conf`

## Clearing Cache

To completely clear everything in the cache, run

`/etc/nginx/scripts/clear-cache.sh`

# Statistics

To find out what's stored in the cache, how much data has been served and which clients
have been using the cache, set up Filebeat and ELK to parse logs and show visual statistics.

## On Your Lancache Server

1. [Install Filebeat](https://www.elastic.co/guide/en/beats/libbeat/current/setup-repositories.html)

2. Install Lancache Filebeat configuration file:

`/etc/nginx/install/install-filebeat-config.sh`

## On Your Statistics Server

1. [Install ELK](https://www.digitalocean.com/community/tutorials/how-to-install-elasticsearch-logstash-and-kibana-elk-stack-on-ubuntu-14-04)

2. Set up [zeropingheroes/lancache-elk](https://github.com/zeropingheroes/lancache-elk)

# Known Issues

## Cache Corruption
In the very unlikely event that the cache stores and serves up a corrupted file, only some download clients handle this helpfully for us:

* **Blizzard** - **OK** - Re-requests the file with headers `Pragma: no-cache` and `Cache-control: no-cache` which causes Nginx to bypass the cache and request a fresh copy of the file from upstream 
* **Origin** - **Not OK** - All requests are sent with `Pragma: no-cache` and `Cache-control: no-cache` and we ignore these or nothing would be cached. If a file is corrupt in the cache there is no mechanism for the Origin client to request Nginx fetches a fresh copy of the file from upstream
* **Windows Update** - **Untested**
* **Riot** - **Untested**
* **Steam** - Steam will re-requests a corrupt file from the cache, but will never send `Pragma: no-cache` and `Cache-control: no-cache` headers

## Incorrect Cache Hit/Miss Stats for Blizzard and Origin
Because we use `slice` for these upstreams, Nginx reports a cache hit for almost all requests from clients, as the single client request has spawned one or more subrequests which fill the cache.
If you have a workaround for this behaviour, please submit a pull request. 

# Contributing

Please submit pull requests to useful changes and enhancements.

I'd reccomend you read [Nginx's Caching blog post](https://www.nginx.com/blog/nginx-high-performance-caching/) to understand caching before diving straight in.

Below are a few ways you can help:

## Caching Another Content Provider

### Create Files
Each cache has two files:

* `caches-available/cache-name.conf` - Defines basic logging info
* `upstreams/cache-name.conf` - Defines what should be cached

Duplicate an existing cache's files as a template.

### Edit Configuration

#### Server Names

Set the primary server name to `lancache-(cachename)`

`server_name lancache-battletoads;`

For all other server names, you must discover each [FQDN](https://en.wikipedia.org/wiki/Fully_qualified_domain_name) a 
content provider uses to serve content and add it to the list of server names.

`server_name content1.battletoads.net;`

#### Proxy & Cache / Proxy Only

Each `location {}` context can either include `includes/proxy-cache-upstream.conf` to proxy
and cache the upstream, or include `includes/proxy-upstream.conf` to only proxy, and not
cache any content.

Directives in these files can be overriden in the parent configuration
after the `include` statement.

```
location / {
    # Load settings to only proxy this upstream location (no caching)
    include includes/proxy-upstream.conf;
}

location / {
    # Load settings to proxy and cache this upstream location
    include includes/proxy-cache-upstream.conf;

    # Cache data in the cache named "installers" 
    proxy_cache installers;
```
