#!/bin/bash

if [ "/etc/nginx/conf.d/default.conf" ]; then
  echo "Change default.conf root route"
  sed -i "s|    root /var/www/app;|    root /var/www/app/public;|" /etc/nginx/conf.d/default.conf
  sed -i "s|         fastcgi_param SCRIPT_FILENAME /var/www/app/index.php;|         fastcgi_param SCRIPT_FILENAME /var/www/app/public/index.php;|" /etc/nginx/conf.d/default.conf
else
  echo "Error: '/etc/nginx/conf.d/default.conf' not found"
fi
