FROM maxvanderschee/nginx-php

LABEL maintainer "m.v.d.schee@ewake.nl"

# Install core packages for laravel.
RUN apt-get update -q
RUN apt-get install -y php7.0-cli php7.0-mcrypt php7.0-mbstring php7.0-xml php7.0-curl php7.0-mysql
RUN apt-get clean -q && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Setup nginx config
WORKDIR /etc/nginx/snippets/
COPY security.conf security.conf

# Configure nginx file for domain
WORKDIR /etc/my_init.d
COPY bash.sh 02_laravel.sh
RUN chmod +x 02_laravel.sh

# Install composer
WORKDIR /root
RUN curl -sS https://getcomposer.org/installer | php
RUN mv /root/composer.phar /usr/local/bin/composer

# Set execute work directory
WORKDIR /var/www/app
