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

Add alias IPs to server's network interface:

`nano /etc/networking/interfaces`

```
# Change eth0 to your network interface name
# Change IP addresses to addresses inside your network
auto eth0
iface eth0 inet static
        address 10.1.1.250
        netmask 255.255.255.0
        gateway 10.1.1.1
        dns-nameservers 10.1.1.1
auto eth0:0
iface eth0:0 inet static
        address 10.1.1.200
        netmask 255.255.255.0
        dns-nameservers 10.1.1.1

auto eth0:1
iface eth0:1 inet static
        address 10.1.1.201
        netmask 255.255.255.0
        dns-nameservers 10.1.1.1
auto eth0:2
iface eth0:2 inet static
        address 10.1.1.202
        netmask 255.255.255.0
        dns-nameservers 10.1.1.1
auto eth0:3
iface eth0:3 inet static
        address 10.1.1.203
        netmask 255.255.255.0
        dns-nameservers 10.1.1.1
auto eth0:4
iface eth0:4 inet static
        address 10.1.1.204
        netmask 255.255.255.0
        dns-nameservers 10.1.1.1
```

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
