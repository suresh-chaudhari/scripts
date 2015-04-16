@echo off

ping -n 30 127.0.0.1 > nul

set dbpath=C:\data\Replication\
set IP=localhost
set ConfigServer=config

IF NOT EXIST %dbpath% (
  mkdir %dbpath%
)
ping -n 5 127.0.0.1 > nul
IF NOT EXIST %dbpath%%ConfigServer%1 (
  mkdir %dbpath%%ConfigServer%1
) 
ping -n 5 127.0.0.1 > nul
IF NOT EXIST %dbpath%%ConfigServer%2 (
  mkdir %dbpath%%ConfigServer%2
)
ping -n 5 127.0.0.1 > nul
IF NOT EXIST %dbpath%%ConfigServer%3 (
  mkdir %dbpath%%ConfigServer%3
)

ping -n 5 127.0.0.1 > nul
start "%ConfigServer%1" mongod --configsvr --dbpath %dbpath%%ConfigServer%1 --port 20001 
ping -n 5 127.0.0.1 > nul 
start "%ConfigServer%2" mongod --configsvr --dbpath %dbpath%%ConfigServer%2 --port 20002 
ping -n 5 127.0.0.1 > nul 
start "%ConfigServer%3" mongod --configsvr --dbpath %dbpath%%ConfigServer%3 --port 20003 

ping -n 120 127.0.0.1 > nul
start "MongosProcess" mongos --configdb %IP%:20001,%IP%:20002,%IP%:20003 --port 27017 --chunkSize 1 
ping -n 90 127.0.0.1 > nul
start "Mongos Query Browser" mongo %IP%:27017/admin add_shard.js --shell

