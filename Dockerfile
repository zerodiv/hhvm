##
# We start from the basic hhvm image.
##
FROM=hhvm/3.18-lts-latest

# setup the root home
ENV HOME /root

# Turn off apt-get being prompty
ENV DEBIAN_FRONTEND noninteractive

# bring all updates in
apt-get update -y

# install the mysql server
apt-get install -y mysql-server

# install postgresql
apt-get install -y postgresql postgresql-contrib
