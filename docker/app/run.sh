#!/bin/bash

# Make sure we're not confused by old, incompletely-shutdown httpd
# context after restarting the container.  httpd won't start correctly
# if it thinks it is already running.
rm -rf /run/httpd/* /tmp/httpd*

chown apache:apache -R /var/log/apache2 /var/www/html/var

exec /usr/sbin/apachectl -DFOREGROUND &
exec /usr/sbin/php-fpm -F

echo "PCIP image ready"