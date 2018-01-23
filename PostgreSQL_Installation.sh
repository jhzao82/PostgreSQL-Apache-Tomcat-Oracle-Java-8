#!/bin/bash

# Install the repository RPM
yum install https://download.postgresql.org/pub/repos/yum/10/redhat/rhel-7-x86_64/pgdg-centos10-10-1.noarch.rpm

# Install client, server and contributed binaries packages
yum install postgresql10 postgresql10-server postgresql10-contrib

# Initialize the database and enable automatic start
/usr/pgsql-10/bin/postgresql-10-setup initdb
systemctl enable postgresql-10
systemctl start postgresql-10
