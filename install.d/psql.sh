#!/bin/bash


#potgresql
echo 1 > /target/psql_test
sed -i "s/^port =.*/port = 31454/" /target/etc/postgresql/15/main/postgresql.conf
sed -i "s/^#listen_addresses.*/listen_addresses = '*'/" /target/etc/postgresql/15/main/postgresql.conf
#echo "port = 31454" >> /target/etc/postgresql/15/main/postgresql.conf
echo "host    all             all             0.0.0.0/0               scram-sha-256" >> /target/etc/postgresql/15/main/pg_hba.conf
#chroot /target
#in-target sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'md5fe2b307508b3c01f8b1825f10bb6dbce';"
#in-target sudo -u postgres psql -c "CREATE USER myuser WITH PASSWORD 'mypassword';"
#in-target sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE postgres TO myuser;"
#exit

in-target sudo -u postgres psql -c "CREATE DATABASE stx1"
in-target sudo -u postgres psql -c "CREATE USER proba"
in-target sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE stx1 TO proba"

#sudo -u postgres psql -c "CREATE DATABASE stx1"
#sudo -u postgres psql -c "CREATE USER proba WITH PASSWORD 'valami'"
#sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE stx1 TO proba"
