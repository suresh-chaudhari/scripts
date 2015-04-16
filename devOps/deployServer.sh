#!/bin/bash
export CATALINA_HOME="/usr/local/server"
export BACKUP_HOME="/usr/local/backup"
export BUILD_HOME="/home/xyz/"

#take a backup of old build
sudo mv $CATALINA_HOME/*.zip $BACKUP_HOME/
sleep 5
echo -n "Backup taken for older build.."

#stop tomcat
sudo service tomcat stop
sleep 2

#check tomcat status
sudo service tomcat status 

#remove the old build from $CATALINA_HOME folder
sudo rm -rf $CATALINA_HOME/*

#move build 
sudo mv $BUILD_HOME/*.zip $CATALINA_HOME/
sleep 5

#unzip server build
sudo unzip $CATALINA_HOME/*.zip -d $CATALINA_HOME/
sleep 5

#change permission of suresh tomcat server
sudo chown -R suresh:suresh $CATALINA_HOME
sleep 5

#start tomcat tomcat service
sudo service tomcat start

#check the status of tomcat server
sudo service tomcat status 

exit 0
