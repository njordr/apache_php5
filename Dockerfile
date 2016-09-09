FROM ubuntu:16.04

MAINTAINER "Giovanni Colapinto" alfheim@syshell.net

RUN apt-get update \
    && apt-get install -y --no-install-recommends --fix-missing \
    apache2 \
    sudo \
    supervisor \
    php \
    php-bcmath \
    php-calendar \
    php-cli \
    php-common \
    php-curl \
    php-date \
    php-gd \
    php-geoip \
    php-gettext \
    php-imagick \
    php-intl \
    php-mail \
    php-mbstring \
    php-mcrypt \
    php-mysql \
    php-mysqli \
    php-mysqlnd \
    php-opcache \
    php-pdo \
    php-pdo-mysql \
    php-pear \
    php-pecl-http \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/

RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/log/supervisor

COPY conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENV APACHE_RUN_USER www-data 
ENV APACHE_RUN_GROUP www-data 
ENV APACHE_LOG_DIR /var/log/apache2

EXPOSE 80 

# CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
CMD ["/usr/bin/supervisord"]
