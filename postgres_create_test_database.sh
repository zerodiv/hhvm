#!/usr/bin/env bash

# stand up postgres
/etc/init.d/postgresql start

# run the create database
su postgres -c 'psql < /tmp/postgres_create_test_database.sql'
