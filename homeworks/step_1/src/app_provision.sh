#!/bin/bash

sudo apt-get update -y
sudo apt-get install -y openjdk-11-jdk git maven mysql-server

sudo useradd -m -s /bin/bash app_user
sudo passwd -d app_user

echo "DB_USER=${DB_USER}, DB_PASS=${DB_PASS}, DB_NAME=${DB_NAME}"

sudo -u app_user git clone https://github.com/Pavlo-1992/devops_9_pavlo.git "$PROJECT_DIR"

cd "$PROJECT_DIR/homeworks/step_1/petclinic" || exit 1
sudo -u app_user mvn clean package
cp target/*.jar "$PROJECT_DIR/homeworks/step_1/petclinic/web.jar"


sudo -u app_user nohup java \
  -DMYSQL_URL="jdbc:mysql://${DB_HOST}/${DB_NAME}" \
  -DMYSQL_USER="$DB_USER" \
  -DMYSQL_PASS="$DB_PASS" \
  -Dspring.profiles.active=mysql \
  -jar "$PROJECT_DIR/homeworks/step_1/petclinic/web.jar" >/dev/null 2>&1 &
