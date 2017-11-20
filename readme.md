# Laravel

### In Short
This image is optimized for use with **Laravel 5.4**
+ **Nginx** as a fast and efficient webserver.
+ **PHP-FPM** as the FastCGI engine.
+ **Pushion** as the minimal Linux container for this image.

### Usage
**Only works with Docker-Compose**

**Example docker-compose file:**

*docker-compose.yml*

    version: '2'

    services:
      laravel:
        image: maxvanderschee/laravel:latest
        container_name: laravel
        environment:
          VIRTUAL_HOST: example.nl
          VIRTUAL_PROTO: https
          VIRTUAL_PORT: 443
          LETSENCRYPT_HOST: example.nl
          LETSENCRYPT_EMAIL: example@example.nl
        depends_on:
          - database
        volumes:
          - "/var/www/laravel:/var/www/app"
        volumes_from:
          - "nginx-proxy"

      database:
        image: mysql
        container_name: database
        environment:
          MYSQL_ROOT_PASSWORD: ROOTPASSWORD
          MYSQL_DATABASE: database
          MYSQL_USER: user
          MYSQL_PASSWORD: USERPASSWORD
        volumes:
          - "/var/www/mysql:/var/lib/mysql"

      nginx-proxy:
        image: jwilder/nginx-proxy
        container_name: proxy
        restart: always
        ports:
          - "80:80"
          - "443:443"
        volumes:
          - "/etc/nginx/vhost.d"
          - "/usr/share/nginx/html"
          - "/var/run/docker.sock:/tmp/docker.sock:ro"
          - "/etc/nginx/certs"

      letsencrypt-nginx-proxy-companion:
        image: jrcs/letsencrypt-nginx-proxy-companion
        container_name: ssl
        volumes:
          - "/var/run/docker.sock:/var/run/docker.sock:ro"
        volumes_from:
          - "nginx-proxy"

### Dockerfile

+ Define the base image as **maxvanderschee/nginx-php**.
+ Install and update the core components for this new container like PHP7.0-cli, PHP7.0-mcrypt, etc.
+ Install Composer.
