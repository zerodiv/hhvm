#!/usr/bin/env bash

# stand up postgres
/etc/init.d/postgresql start

# run the create database
su postgres -c 'psql < /tmp/postgres_create_test_database.sql'

# setup the postgres password into the .pgpass property file.
echo 'localhost:5432:phpunit:zframework:i-am-a-walrus' > ~/.pgpass
chmod 0600 ~/.pgpass
