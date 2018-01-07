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

