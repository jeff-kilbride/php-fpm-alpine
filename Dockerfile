FROM alpine:3.7

RUN apk add --no-cache php7-fpm \
    php7-bcmath \
    php7-bz2 \
    php7-ctype \
    php7-curl \
    php7-dom \
    php7-exif \
    php7-ftp \
    php7-gd \
    php7-iconv \
    php7-imagick \
    php7-json \
    php7-mcrypt \
    php7-memcached \
    php7-mysqli \
    php7-opcache \
    php7-openssl \
    php7-pdo_mysql \
    php7-redis \
    php7-simplexml \
    php7-xdebug \
    php7-xml \
    php7-zip && \
    rm -f /etc/php7/conf.d/xdebug.ini && \
    sed -i -e "s|;daemonize\s*=.*|daemonize = no|" \
    /etc/php7/php-fpm.conf && \
    sed -i -e "s|listen\s*=.*|listen = 9000|" \
    -e "s|;clear_env = no|clear_env = no|" \
    /etc/php7/php-fpm.d/www.conf && \
    sed -i -e "s|upload_max_filesize\s*=.*|upload_max_filesize = 100M|" \
    -e "s|max_file_uploads\s*=.*|max_file_uploads = 50|" \
    -e "s|post_max_size\s*=.*|post_max_size = 100M|" \
    -e "s|;cgi.fix_pathinfo\s*=.*|cgi.fix_pathinfo = 1|" \
    /etc/php7/php.ini && \
    mv /etc/profile.d/color_prompt /etc/profile.d/color_prompt.sh && \
    mkdir -p /var/www/app/webroot

COPY info.php /var/www/app/webroot/
COPY config/xdebug.ini /etc/php7/conf.d/
COPY aliases.sh /etc/profile.d/

VOLUME ["/var/www"]

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7"]

LABEL maintainer="Jeff Kilbride <jeff@kilbride.com>" \
    org.label-schema.docker.dockerfile="/Dockerfile" \
    org.label-schema.license="MIT" \
    org.label-schema.name="PHP-FPM Alpine" \
    org.label-schema.vcs-type="Git" \
    org.label-schema.vcs-url="https://github.com/jeff-kilbride/php-fpm-alpine"
