#!/usr/bin/env bash

# 1) stand up postgres
# 2) run the create database
# 3) setup the postgres password into the .pgpass property file.
/etc/init.d/postgresql start && \
  su postgres -c 'psql < /tmp/postgres_create_test_database.sql' && \
  echo 'localhost:5432:phpunit:zframework:i-am-a-walrus' > ~/.pgpass && \
  chmod 0600 ~/.pgpass
