#!/bin/bash

yum update -y && yum upgrade -y
yum install httpd -y
echo "This is APP_1" > /var/www/html/index.html
# echo "LoadModule rewrite_module modules/mod_rewrite.so" >> /etc/httpd/conf/httpd.conf
service httpd restart