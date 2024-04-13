#!/bin/bash
set -e

sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install postgresql-13
cd /etc/postgresql/13/main
export key=$(curl https://ipinfo.io/ip ;)
sleep 10
sudo sed -i "s/#listen_addresses/listen_addresses/" /etc/postgresql/13/main/postgresql.conf
sleep 5
sudo sed -i "s/localhost/*/" /etc/postgresql/13/main/postgresql.conf
sleep 5
sudo sed -i '96 s/127.0.0.1\/32/0.0.0.0\/0/g' /etc/postgresql/13/main/pg_hba.conf
DB_NAME=postgresmain
DB_USER=postgres123
DB_USER_PASS=postgres123
sudo su - postgres <<EOF
createdb  $DB_NAME;
psql -c "CREATE USER $DB_USER WITH PASSWORD '$DB_USER_PASS';"
psql -c "grant all privileges on database $DB_NAME to $DB_USER;"
echo "Postgres User '$DB_USER' and database '$DB_NAME' created."
cd /usr/lib/postgresql/13/bin

./pg_ctl -D /var/lib/postgresql/13/main restart

echo "Postgres User '$DB_USER'  and database '$DB_NAME' created successfully please test".

exit

EOF
