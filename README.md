# LANcache
Automatically cache game files at LAN parties using [Nginx](http://nginx.org/) as a reverse proxy.

Forked from [Lochnair/lancache](https://github.com/Lochnair/lancache)

# Requirements
Tested on Ubuntu 16.04

# Installation

Enter an interative superuser shell:

`sudo -i`

Create the Nginx config directory:

`mkdir /etc/nginx && cd /etc/nginx`

Clone this repository into it:

`git clone https://github.com/zeropingheroes/lancache.git .`

Make all the scripts in the install directory executable:

`chmod -R +x /etc/nginx/install/`

Compile Nginx from source:

`/etc/nginx/install/compile-nginx.sh`

Prepare directories:

`/etc/nginx/install/prepare-directories.sh`

# Required DNS Entries

## Steam
- cs.steampowered.com
- *.cs.steampowered.com
- content1.steampowered.com
- content2.steampowered.com
- content3.steampowered.com
- content4.steampowered.com
- content5.steampowered.com
- content6.steampowered.com
- content7.steampowered.com
- content8.steampowered.com
- content-origin.steampowered.com
- client-download.steampowered.com
- *.hsar.steampowered.com.edgesuite.net
- *.akamai.steamstatic.com
- *.steamcontent.com

## Riot
- l3cdn.riotgames.com
- worldwide.l3cdn.riotgames.com

## Blizzard
- dist.blizzard.com.edgesuite.net
- llnw.blizzard.com
- dist.blizzard.com

## Sony
- pls.patch.station.sony.com

## Windows Update
- *.windowsupdate.com
- *.dl.delivery.mp.microsoft.com

# Example Unbound Config
Change IP address `10.1.1.250` to your server's IP address
```
server:

# Steam
local-data: "content1.steampowered.com A 10.1.1.250"
local-data: "content2.steampowered.com A 10.1.1.250"
local-data: "content3.steampowered.com A 10.1.1.250"
local-data: "content4.steampowered.com A 10.1.1.250"
local-data: "content5.steampowered.com A 10.1.1.250"
local-data: "content6.steampowered.com A 10.1.1.250"
local-data: "content7.steampowered.com A 10.1.1.250"
local-data: "content8.steampowered.com A 10.1.1.250"
local-data: "content-origin.steampowered.com A 10.1.1.250"
local-data: "client-download.steampowered.com A 10.1.1.250"
local-zone: "cs.steampowered.com" redirect
local-data: "cs.steampowered.com A 10.1.1.250"
local-zone: "steamcontent.com" redirect
local-data: "steamcontent.com A 10.1.1.250"
local-zone: "hsar.steampowered.com.edgesuite.net" redirect
local-data: "hsar.steampowered.com.edgesuite.net A 10.1.1.250"
local-zone: "akami.steamstatic.com" redirect
local-data: "akami.steamstatic.com A 10.1.1.250"

# Riot
local-data: "l3cdn.riotgames.com A 10.1.1.250"
local-data: "worldwide.l3cdn.riotgames.com A 10.1.1.250"

# Blizzard
local-data: "dist.blizzard.com.edgesuite.net A 10.1.1.250"
local-data: "llnw.blizzard.com A 10.1.1.250"
local-data: "dist.blizzard.com A 10.1.1.250"

# Sony
local-data: "pls.patch.station.sony.com A 10.1.1.250"

# Windows Update
local-zone: "windowsupdate.com" redirect
local-data: "windowsupdate.com A 10.1.1.250"
local-zone: "dl.delivery.mp.microsoft.com" redirect
local-data: "dl.delivery.mp.microsoft.com A 10.1.1.250"
```
