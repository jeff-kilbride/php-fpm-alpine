FROM alpine:3.4

MAINTAINER Jeff Kilbride <jeff@kilbride.com>

RUN echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
  echo "@community http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
  apk add --no-cache php5-fpm \
  php5-bcmath \
  php5-bz2 \
  php5-ctype \
  php5-curl \
  php5-exif \
  php5-ftp \
  php5-gd \
  php5-geoip@testing \
  php5-imagick \
  php5-json \
  php5-mcrypt \
  php5-memcached@testing \
  php5-mysqli \
  php5-opcache \
  php5-openssl \
  php5-pdo_mysql \
  php5-phpmailer \
  php5-redis@testing \
  php5-xdebug@community \
  php5-zip \
  php5-zlib && \
  rm -f /etc/php5/conf.d/xdebug.ini && \
  sed -i -e "s|;daemonize\s*=.*|daemonize = no|" \
    -e "s|listen\s*=.*|listen = 9000|" \
    /etc/php5/php-fpm.conf && \
  sed -i -e "s|upload_max_filesize\s*=.*|upload_max_filesize = 100M|" \
    -e "s|max_file_uploads\s*=.*|max_file_uploads = 50|" \
    -e "s|post_max_size\s*=.*|post_max_size = 100M|" \
    -e "s|;cgi.fix_pathinfo\s*=.*|cgi.fix_pathinfo = 1|" \
    /etc/php5/php.ini && \
  mv /etc/profile.d/color_prompt /etc/profile.d/color_prompt.sh && \
  mkdir -p /var/www/app/webroot

COPY info.php /var/www/app/webroot/
COPY config/xdebug.ini /etc/php5/conf.d/
COPY aliases.sh /etc/profile.d/

VOLUME ["/var/www"]

EXPOSE 9000

CMD ["/usr/bin/php-fpm"]

LABEL org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.license="MIT" \
      org.label-schema.name="PHP-FPM Alpine" \
      org.label-schema.vcs-type="Git" \
      org.label-schema.vcs-url="https://github.com/jeff-kilbride/php-fpm-alpine"
