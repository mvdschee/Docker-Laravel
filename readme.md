# Laravel

### In Short
This image is optimized for use with **Laravel 5.4**
+ **Nginx** as a fast and efficient webserver.
+ **PHP-FPM** as the FastCGI engine.
+ **Pushion** as the minimal Linux container for this image.
+ **Let's Encrypt** as the certificate authority.

### Usage
**Only works with Docker-Compose**

**Example non-ssl:**

*docker-compose.yml*

    version: '2'

    services:
      db:
        image: mysql
        environment:
          MYSQL_ROOT_PASSWORD: SECRETPASSWORD
          MYSQL_DATABASE: DATABASENAME
          MYSQL_USER: USER
          MYSQL_PASSWORD: USERPASSWORD

      laravel:
        depends_on:
            - db
        image: maxvanderschee/laravel:latest
        volumes:
          - /var/www/YOURWEBSITE:/var/www/app
        environment:
          CONF: non-ssl.conf
          APPURL: YOURWEBSITE.COM
        ports:
          - "80:80"

**Example ssl:**

*docker-compose.yml*

    version: '2'

    services:
      db:
        image: mysql
        environment:
          MYSQL_ROOT_PASSWORD: SECRETPASSWORD
          MYSQL_DATABASE: DATABASENAME
          MYSQL_USER: USER
          MYSQL_PASSWORD: USERPASSWORD

      laravel:
        depends_on:
            - db
        image: maxvanderschee/laravel:latest
        volumes:
          - /var/www/YOURWEBSITE:/var/www/app
          - /root/archive:/etc/letsencrypt/archive
        environment:
          CONF: ssl.conf
          APPURL: YOURWEBSITE.COM
        ports:
          - "80:80"
          - "443:443"

The next step is to login to the container and execute:

``sudo letsencrypt certonly -a webroot --webroot-path=/var/www/app -d YOURWEBSITE.COM -d www.YOURWEBSITE.COM``

The last step is to restart Nginx.

### Dockerfile

+ Define the base image as **maxvanderschee/nginx-php**.
+ Install and update the core components for this new container like PHP7.0-cli, PHP7.0-mcrypt, etc.
+ Install Composer.
