#!/bin/bash

yum update -y && yum upgrade -y
yum install httpd -y
mkdir -p /var/www/html/app3
echo "This is APP_3" > /var/www/html/app3/index.html
# echo "LoadModule rewrite_module modules/mod_rewrite.so" >> /etc/httpd/conf/httpd.conf
service httpd restart