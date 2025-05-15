#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y openjdk-11-jdk git maven mysql-server

sudo useradd -m -s /bin/bash app_user
sudo passwd -d app_user

sudo -u app_user git clone https://github.com/Pavlo-1992/devops_9_pavlo.git /home/app_user/project_dir
chown app_user /home/app_user/project_dir

su - app_user

cd /home/app_user/project_dir/homeworks/step_1/petclinic
chmod +x mvnw
./mvnw package
java -jar target/*.jar
