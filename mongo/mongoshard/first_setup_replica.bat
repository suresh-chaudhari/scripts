@echo off

set dbpath=C:\data\Replication\
set IP=localhost
set replicaSet=firstset

IF NOT EXIST %dbpath% (
  mkdir %dbpath%
)
ping -n 5 127.0.0.1 > nul
IF NOT EXIST %dbpath%%replicaSet%1 (
  mkdir %dbpath%%replicaSet%1
) 
IF NOT EXIST %dbpath%%replicaSet%2 (
  mkdir %dbpath%%replicaSet%2
)
IF NOT EXIST %dbpath%%replicaSet%3 (
  mkdir %dbpath%%replicaSet%3
)

start "%replicaSet%1" mongod --dbpath %dbpath%%replicaSet%1 --port 10001 --replSet %replicaSet% --oplogSize 700 --rest 
start "%replicaSet%2" mongod --dbpath %dbpath%%replicaSet%2 --port 10002 --replSet %replicaSet% --oplogSize 700 --rest
start "%replicaSet%3" mongod --dbpath %dbpath%%replicaSet%3 --port 10003 --replSet %replicaSet% --oplogSize 700 --rest 

ping -n 10 127.0.0.1 > nul
rem echo "starting mongo for first..."
start "First Mongo Console" mongo %IP%:10001/admin first_init_replica.js  --shell
ping -n 30 127.0.0.1 > nul
rem echo "First Replica done..."

rem Note The --oplogSize 700 option restricts the size of the operation log (i.e. oplog) for each mongod instance to 700MB. 
rem Without the --oplogSize option, each mongod reserves approximately 5% of the free disk space on the volume. 
rem By limiting the size of the oplog, each instance starts more quickly. Omit this setting in production environments.
