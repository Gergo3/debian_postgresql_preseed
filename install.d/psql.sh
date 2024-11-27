#!/bin/bash


#potgresql
in-target sed -i "s/#port = 5432/port = 31454/" /etc/postgresql//main/postgresql.conf; \
in-target echo "host    all             all             0.0.0.0/0               md5" >> /etc/postgresql//main/pg_hba.conf; \
in-target sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'md5fe2b307508b3c01f8b1825f10bb6dbce';"; \
in-target sudo -u postgres psql -c "CREATE USER myuser WITH PASSWORD 'mypassword';"; \
in-target sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE postgres TO myuser;"; \
in-target systemctl restart postgresql
