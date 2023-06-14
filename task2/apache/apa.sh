#!/bin/bash

mkdir -p /var/www/gammaz

cp /home/had/mess.txt /var/www/gammaz/mess.txt

touch /etc/apache2/sites-available/gammaz.hm.conf

echo "<VirtualHost *:80>
     ServerAdmin webmaster@gammaz.hm.com
     ServerName gammaz.hm.com
     ServerAlias www.gammaz.hm.com
     DocumentRoot /var/www/gammaz
</VirtualHost>" >> /etc/apache2/sites-available/gammaz.hm.conf

echo "ServerName gammaz.hm" >> /etc/apache2/apache2.conf

service apache2 start

a2ensite gammaz.hm.conf

a2dissite 000-default.conf

service apache2 reload
