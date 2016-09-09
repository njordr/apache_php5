FROM ubuntu:16.04

MAINTAINER "Giovanni Colapinto" alfheim@syshell.net

RUN apt-get update \
    && apt-get install -y --no-install-recommends --fix-missing \
    apache2 \
    sudo \
    supervisor \
    software-properties-common \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/

RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php \
    && apt-get update \
    && apt-get install -y --no-install-recommends --fix-missing \
    php5.6 \
    php5.6-bcmath \
    php5.6-calendar \
    php5.6-cli \
    php5.6-common \
    php5.6-curl \
    php5.6-gd \
    php5.6-geoip \
    php5.6-iconv \
    php5.6-imagick \
    php5.6-intl \
    php5.6-json \
    php5.6-mbstring \
    php5.6-mcrypt \
    php5.6-mysql \
    php5.6-mysqli \
    php5.6-mysqlnd \
    php5.6-opcache \
    php5.6-pdo \
    php5.6-pdo-mysql \
    php5.6-soap \
    php5.6-zip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/

RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/log/supervisor

COPY conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENV APACHE_RUN_USER www-data 
ENV APACHE_RUN_GROUP www-data 
ENV APACHE_LOG_DIR /var/log/apache2
ENV PHP_VERSION 5.6.25

EXPOSE 80 

# CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
CMD ["/usr/bin/supervisord"]
