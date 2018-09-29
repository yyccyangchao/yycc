#!/bin/bash
#压缩包lnmp_soft.tar.gz得在/root/底下
yum -y install gcc openssl-devel pcre-devel zlib-devel
tar -xf lnmp_soft.tar.gz
cd lnmp_soft
tar -xf nginx-1.12.2.tar.gz
cd nginx-1.12.2
useradd -s /sbin/nologin nginx
./configure --with-http_ssl_module --with-stream --with-http_stub_status_module --user=nginx --group=nginx
# ./configure --with-http_ssl_module --with-stream
make && make install
yum -y install mariadb mariadb-server mariadb-devel
yum -y install php php-mysql
yum -y install /root/lnmp_soft/php-fpm-5.4.16-42.el7.x86_64.rpm
sed -i '65,71s/#//' /usr/local/nginx/conf/nginx.conf
sed -i '70s/fastcgi_params/fastcgi.conf/' /usr/local/nginx/conf/nginx.conf
sed -i '69d' /usr/local/nginx/conf/nginx.conf
systemctl stop httpd
systemctl restart mariadb
systemctl restart php-fpm
/usr/local/nginx/sbin/nginx
ln -s /usr/local/nginx/sbin/nginx /sbin/
echo '<?php
$a=88888;
echo $a;
?>' > /usr/local/nginx/html/test.php
