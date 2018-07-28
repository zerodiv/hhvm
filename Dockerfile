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

# stand up mysql
RUN /etc/rc.d/init.d/mysql start

# download our database creation script
RUN curl -O /tmp/my_create_test_database.sql https://raw.githubusercontent.com/zynga/zynga-hacklang-framework/master/tests/sql/mysql/create_test_database.sql

# run the create database
RUN mysql < /tmp/my_create_test_database.sql

# display status
RUN mysql -e 'SHOW DATABASES'
RUN mysql -e 'SHOW TABLES' phpunit

# install postgresql
RUN apt-get install -y postgresql postgresql-contrib

# stand up postgres
RUN /etc/init.d/postgresql start

# download our database creation script
RUN curl -O /tmp/pg_create_test_database.sql https://raw.githubusercontent.com/zynga/zynga-hacklang-framework/master/tests/sql/postgresql/create_test_database.sql

# run the create database
RUN su postgres -c 'psql < /var/source/tests/sql/postgresql/create_test_database.sql'

# setup the postgres password into the .pgpass property file.
RUN echo "localhost:5432:phpunit:zframework:i-am-a-walrus" > ~/.pgpass
RUN chmod 0600 ~/.pgpass

RUN echo '\d' | psql --user=zframework --host=localhost phpunit

# install the composer binary to /usr/local/bin
RUN curl https://getcomposer.org/installer | hhvm --php -- /dev/stdin --install-dir=/usr/local/bin --filename=composer

# turn off the jit
echo hhvm.jit=0 >> /etc/hhvm/php.ini
