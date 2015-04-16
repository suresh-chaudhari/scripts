@echo off

set dbpath=C:\data\Replication\
IF NOT EXIST %dbpath% (
  mkdir %dbpath%
)

:SELECTION
echo 1. Configure Replica.
echo 2. Create Replica Member.

set /P I="Enter Choise: "
if "%I%" == "1" (
	goto CONFIGURE_REP
) else if "%I%" == "2" (
	goto RPL_MEMBER 
) else (
 echo Invalid Choise
 goto :SELECTION
)

:RPL_MEMBER
set /P host="Enter host or hit Enter for default "localhost": "
if "%host%" == "" (
	set host=localhost
)
echo %host%

:CONFIGURE_REP
set /P replica="Enter Odd number of replica you want to configure: "
if %replica% lss 3 (
	echo "Minimum number of replica should be 3"
	goto CONFIGURE_REP
)
set /P host="Enter host or hit Enter for default "localhost": "
if "%host%" == "" (
	set host=localhost
)
set /P port="Enter Port number: "
set /P replicaSet="Enter the replica set name: "

SET /a i=0
:loop
IF %i%==%replica% GOTO end
SET /a i=%i%+1
IF NOT EXIST %dbpath%%replicaSet%%i% (
  mkdir %dbpath%%replicaSet%%i%
)
ping -n 2 127.0.0.1 > nul
set /a port=%port%+1
start "%replicaSet%%i%" mongod --dbpath %dbpath%%replicaSet%%i% --port %port% --replSet %replicaSet% --oplogSize 700 --rest
ping -n 2 127.0.0.1 > nul
GOTO LOOP
:end
ping -n 10 127.0.0.1 > nul
start "First Mongo Console" mongo %host%:10001/admin db.runCommand({"replSetInitiate" :{"_id" : "firstset", "members" : [{"_id" : 1, "host" : "localhost:10001"},
                                                      {"_id" : 2, "host" : "localhost:10002"},
                                                      {"_id" : 3, "host" : "localhost:10003"}
             ]}})  --shell
ping -n 30 127.0.0.1 > nul

pause
 
