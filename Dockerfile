FROM alpine:3.3

MAINTAINER Jeff Kilbride <jeff@kilbride.com>

WORKDIR /root
COPY .profile .

RUN echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories && \
  apk add --no-cache php-fpm \
  php-bcmath \
  php-bz2 \
  php-ctype \
  php-curl \
  php-exif \
  php-ftp \
  php-geoip \
  php-imagick \
  php-json \
  php-mcrypt \
  php-memcached \
  php-mysqli \
  php-opcache \
  php-openssl \
  php-pdo_mysql \
  php-phpmailer \
  php-redis \
  php-xdebug \
  php-zip \
  php-zlib && \
  sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php/php-fpm.conf && \
  sed -i -e "s/listen\s*=\s*127.0.0.1:9000/listen = 9000/g" /etc/php/php-fpm.conf && \
  sed -i "s|upload_max_filesize =.*|upload_max_filesize = 100M|" /etc/php/php.ini && \
  sed -i "s|max_file_uploads =.*|max_file_uploads = 50|" /etc/php/php.ini && \
  sed -i "s|post_max_size =.*|post_max_size = 100M|" /etc/php/php.ini && \
  sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=1/" /etc/php/php.ini

EXPOSE 9000

ENTRYPOINT ["/usr/bin/php-fpm"]
