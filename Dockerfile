##
# We start from the basic hhvm image.
##
FROM hhvm/hhvm:3.18-lts-latest

# setup the root home
ENV HOME /root

# Turn off apt-get being prompty
ENV DEBIAN_FRONTEND noninteractive

# bring all updates in
RUN apt-get update -y

# install modules we need to use to test with.
RUN apt-get install -y wget curl git make time

# install memcached, don't need to spin it up to init anything
RUN apt-get install -y memcached

# install the mysql server
RUN apt-get install -y mysql-server

# install postgresql
RUN apt-get install -y postgresql postgresql-contrib

# install the composer binary to /usr/local/bin
CMD curl https://getcomposer.org/installer | hhvm --php -- /dev/stdin --install-dir=/usr/local/bin --filename=composer

# turn off the jit
CMD echo hhvm.jit=0 >> /etc/hhvm/php.ini

# setup the postgres password into the .pgpass property file.
CMD ["echo", "'localhost:5432:phpunit:zframework:i-am-a-walrus'", "> ~/.pgpass"]
CMD ["chmod", "0600", "~/.pgpass"]

# Inject a default test database for mysql
COPY mysql_create_test_database.sql /tmp
COPY mysql_create_test_database.sh /tmp
RUN chmod +x /tmp/mysql_create_test_database.sh
CMD bash /tmp/mysql_create_test_database.sh

# Inject a default test database for postgres
COPY postgres_create_test_database.sql /tmp
COPY postgres_create_test_database.sh /tmp
RUN chmod +x /tmp/postgres_create_test_database.sh
CMD bash /tmp/postgres_create_test_database.sh
