@echo off

set dbpath=C:\data\Replication\
set IP=localhost
set replicaSet=secondset

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

rem for /l %%x in (1, 1, 3) do echo start "%replicaSet%%%x" mongod --dbpath %replicationPath%%replicaSet%%%x --port 1000%x --replSet %replicaSet%%%x --oplogSize 700 --rest 
start "%replicaSet%1" mongod --dbpath %dbpath%%replicaSet%1 --port 10004 --replSet %replicaSet% --oplogSize 700 --rest 
start "%replicaSet%2" mongod --dbpath %dbpath%%replicaSet%2 --port 10005 --replSet %replicaSet% --oplogSize 700 --rest
start "%replicaSet%3" mongod --dbpath %dbpath%%replicaSet%3 --port 10006 --replSet %replicaSet% --oplogSize 700 --rest 

ping -n 20 127.0.0.1 > nul
start "Second Mongo Console" mongo %IP%:10004/admin second_init_replica.js  --shell
ping -n 30 127.0.0.1 > nul
