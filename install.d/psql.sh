#!/bin/bash


#potgresql
echo 1 > /target/psql_test
#sed -i "s/#port = 5432					# (change requires restart)/port = 31454/" /target/etc/postgresql/15/main/postgresql.conf
echo "port = 31454" >> /target/etc/postgresql/15/main/postgresql.conf
echo "host    all             all             0.0.0.0/0               md5" >> /target/etc/postgresql/15/main/pg_hba.conf
#chroot /target
in-target sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'md5fe2b307508b3c01f8b1825f10bb6dbce';"
#in-target sudo -u postgres psql -c "CREATE USER myuser WITH PASSWORD 'mypassword';"
#in-target sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE postgres TO myuser;"
#exit
