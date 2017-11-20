#!/bin/bash

if [ -d "/etc/nginx/conf.d/default.conf" ]; then
  echo "Change default.conf root route"
  sed -i "s|    root /var/www/app;|    root /var/www/app/public;|" /etc/nginx/conf.d/default.conf
else
  echo "Error: '/etc/nginx/conf.d/default.conf' not found"
fi
