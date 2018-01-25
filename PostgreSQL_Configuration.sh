#!/bin/bash

# vi /var/lib/pgsql/10/data/pg_hba.conf

echo 'local all all trust' >> /var/lib/pgsql/10/data/pg_hba.conf
echo 'local atar atar trust' >> /var/lib/pgsql/10/data/pg_hba.conf
echo 'host all all 127.0.0.1/32 trust' >> /var/lib/pgsql/10/data/pg_hba.conf
echo 'host all all ::1/128 ident' >> /var/lib/pgsql/10/data/pg_hba.conf

systemctl restart postgresql-10.service
su - postgres
createdb atar;
psql
CREATE ROLE "atar" WITH PASSWORD 'atarpass';
GRANT ALL PRIVILEGES ON DATABASE atar TO atar;
ALTER ROLE atar WITH LOGIN;
