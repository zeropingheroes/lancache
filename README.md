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
