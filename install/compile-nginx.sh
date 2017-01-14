#!/bin/bash
set -e # abort script if there is an error

echo "Installing compilation tools from apt"
apt update -y
apt install build-essential make

URL_NGINX="http://nginx.org/download/nginx-1.10.2.tar.gz"
URL_PCRE="http://downloads.sourceforge.net/project/pcre/pcre/8.39/pcre-8.39.tar.gz"

SRC="/usr/local/src"

PATH_NGINX="$TMP/nginx"
PATH_PCRE="$TMP/pcre"

mkdir -p $PATH_NGINX
mkdir -p $PATH_PCRE

echo "Downloading and uncompressing Nginx source"
wget $URL_NGINX -O - | tar -xz  -C $PATH_NGINX --strip-components 1

echo "Downloading and uncompressing PCRE source"
wget $URL_PCRE -O - | tar -xz -C $PATH_PCRE --strip-components 1

echo "Compiling PCRE from source in $PATH_PCRE"
cd $PATH_PCRE
./configure
make
make install

echo "Compiling NGINX source from source in $PATH_NGINX"
cd $PATH_NGINX

./configure \
        --sbin-path=/usr/local/bin/nginx \
        --conf-path=/etc/nginx/nginx.conf \
        --pid-path=/run/nginx.pid \
        --user=www-data \
        --with-stream \
        --with-http_slice_module \
        --with-http_stub_status_module \
        --with-ld-opt="-Wl,-rpath,/usr/local/lib" \
        --with-pcre=$PATH_PCRE \
        --without-http_gzip_module \
        --without-http_ssi_module \
        --without-http_charset_module \
        --without-http_userid_module \
        --without-http_auth_basic_module \
        --without-http_geo_module \
        --without-http_split_clients_module \
        --without-http_referer_module \
        --without-http_fastcgi_module \
        --without-http_uwsgi_module \
        --without-http_scgi_module \
        --without-http_memcached_module \
        --without-http_limit_conn_module \
        --without-http_limit_req_module \
        --without-http_empty_gif_module \
        --without-http_upstream_hash_module \
        --without-http_upstream_ip_hash_module \
        --without-http_upstream_least_conn_module \
        --without-http_upstream_keepalive_module \
        --without-http_upstream_zone_module
make
make install
