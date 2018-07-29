#!/usr/bin/env bash

# 1) stand up mysql
# 2) do database import
/etc/init.d/mysql start && \
  mysql < /tmp/mysql_create_test_database.sql
