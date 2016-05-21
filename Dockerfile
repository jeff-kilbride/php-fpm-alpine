FROM alpine:edge

MAINTAINER Jeff Kilbride <jeff@kilbride.com>

WORKDIR /root
COPY .profile .

RUN echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
  apk add --no-cache php5-fpm \
  php5-bcmath \
  php5-bz2 \
  php5-ctype \
  php5-curl \
  php5-exif \
  php5-ftp \
  php-geoip@testing \
  php5-imagick \
  php5-json \
  php5-mcrypt \
  php-memcached@testing \
  php5-mysqli \
  php5-opcache \
  php5-openssl \
  php5-pdo_mysql \
  php5-phpmailer \
  php-redis@testing \
  php-xdebug@testing \
  php5-zip \
  php5-zlib && \
  sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/php-fpm.conf && \
  sed -i -e "s/listen\s*=\s*127.0.0.1:9000/listen = 9000/g" /etc/php5/php-fpm.conf && \
  sed -i "s|upload_max_filesize =.*|upload_max_filesize = 100M|" /etc/php5/php.ini && \
  sed -i "s|max_file_uploads =.*|max_file_uploads = 50|" /etc/php5/php.ini && \
  sed -i "s|post_max_size =.*|post_max_size = 100M|" /etc/php5/php.ini && \
  sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=1/" /etc/php5/php.ini

EXPOSE 9000

ENTRYPOINT ["/usr/bin/php-fpm"]
