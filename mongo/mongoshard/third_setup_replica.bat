@echo off

set dbpath=C:\data\Replication\
set IP=localhost
set replicaSet=thirdset

IF NOT EXIST %dbpath% (
  mkdir %dbpath%
)
IF NOT EXIST %dbpath%%replicaSet%1 (
  mkdir %dbpath%%replicaSet%1
) 
IF NOT EXIST %dbpath%%replicaSet%2 (
  mkdir %dbpath%%replicaSet%2
)
IF NOT EXIST %dbpath%%replicaSet%3 (
  mkdir %dbpath%%replicaSet%3
)

start "%replicaSet%1" mongod --dbpath %dbpath%%replicaSet%1 --port 10007 --replSet %replicaSet% --oplogSize 700 --rest 
start "%replicaSet%2" mongod --dbpath %dbpath%%replicaSet%2 --port 10008 --replSet %replicaSet% --oplogSize 700 --rest
start "%replicaSet%3" mongod --dbpath %dbpath%%replicaSet%3 --port 10009 --replSet %replicaSet% --oplogSize 700 --rest 

ping -n 30 127.0.0.1 > nul
start "Third Mongo Console" mongo %IP%:10007/admin third_init_replica.js  --shell
ping -n 30 127.0.0.1 > nul
