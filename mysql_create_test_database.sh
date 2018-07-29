#!/usr/bin/env bash

/etc/rc.d/init.d/mysql start
mysql < /tmp/mysql_create_test_database.sql
