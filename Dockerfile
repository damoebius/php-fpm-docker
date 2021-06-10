FROM php:7.4-fpm
RUN \
 echo "**** install dependencies ****" && \
 apt-get update && apt-get install -y libonig-dev zlib1g-dev libpng-dev libjpeg-dev libzip-dev libicu-dev && \
 echo "**** add modules ****" && \
 docker-php-ext-configure opcache --enable-opcache && \
 docker-php-ext-install mysqli mbstring gd zip intl opcache && \
 echo "**** user configuration ****" && \
 usermod -u 1000 www-data && \
 groupmod -g 1000 www-data && \
 echo "**** cleanup ****" && \
 apt-get clean && \
 rm -rf \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/tmp/*

COPY opcache.ini $PHP_INI_DIR/conf.d/
