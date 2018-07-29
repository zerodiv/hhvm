#!/usr/bin/env bash

# 1) bring all updates in
# 2) basic functionality package installation wget, curl, git, make, time, vim
# 3) install memcached, don't need to spin it up to init anything
# 4) install the mysql server
# 5) install the postgresql instance
# 6) install composer with hhvm
# 7) turn off the hhvm jit by default
# X) create the mysql database
# X) create the postgres database
apt-get update -y && \
apt-get install -y wget curl git make time vim && \
apt-get install -y memcached && \
apt-get install -y mysql-server && \
apt-get install -y postgresql postgresql-contrib && \
curl https://getcomposer.org/installer | hhvm --php -- /dev/stdin --install-dir=/usr/local/bin --filename=composer && \
echo hhvm.jit=0 >> /etc/hhvm/php.ini && \
/tmp/mysql_create_test_database.sh && \
/tmp/postgre_create_test_database.sh
