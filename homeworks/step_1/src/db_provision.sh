#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y mysql-server

sudo sed -i "s/bind-address.*/bind-address = 192.168.56.10/" /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql

echo "DB_USER=${DB_USER}, DB_PASS=${DB_PASS}, DB_NAME=${DB_NAME}"

sudo mysql -u root <<EOF
CREATE USER '${DB_USER}'@'192.168.56.%' IDENTIFIED BY '${DB_PASS}';
CREATE DATABASE ${DB_NAME};
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'192.168.56.%';
FLUSH PRIVILEGES;
EOF
