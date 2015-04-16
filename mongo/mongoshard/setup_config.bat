@echo off

IF NOT EXIST config1 (
  mkdir config1
) 
IF NOT EXIST config2 (
  mkdir config2
)
IF NOT EXIST config3 (
  mkdir config3
)



start "config at 20001" mongod --configsvr --dbpath E:\Bundles\Mongodb\Replication\config1 --port 20001 --rest
start "config at 20002" mongod --configsvr --dbpath E:\Bundles\Mongodb\Replication\config2 --port 20002 --rest
start "config at 20003" mongod --configsvr --dbpath E:\Bundles\Mongodb\Replication\config3 --port 20003 --rest

start "Mongos" mongos --configdb localhost:20001,localhost:20002,localhost:20003 --port 27017 --chunkSize 1 
timeout 10
start "Mongoes Query Browser" mongo localhost:27017/admin add_shard.js --shell
rem If you are using the collection created earlier or are just experimenting with sharding, you can use a small --chunkSize (1MB works well.) 
rem The default chunkSize of 64MB means that your cluster must have 64MB of data before the MongoDB’s automatic sharding begins working.
rem In production environments, do not use a small shard size
