@echo off

:SELECTION
echo 1. Configure One Shard.
echo 2. Configure Two Shard.
echo 3. Configure Three Shard.
echo 4. END.

set /P I="Enter Choise: "
if "%I%" == "1" (
	goto ONE_SHARD
) else if "%I%" == "2" (
	goto TWO_SHARD 
) else if "%I%" == "3" (
	goto THREE_SHARD
) else if "%I%" == "4" (
	goto END
) else (
 echo Invalid Choise
 goto :SELECTION
)

:ONE_SHARD
call first_setup_replica.bat
ping -n 30 127.0.0.1 > nul
call Config_Server_Setup.bat
ping -n 90 127.0.0.1 > nul
start "Mongos Query Browser" mongo %IP%:27017/admin one_add_shard.js --shell
goto SELECTION

:TWO_SHARD
call first_setup_replica.bat
ping -n 10 127.0.0.1 > nul
call second_setup_replica.bat
ping -n 30 127.0.0.1 > nul
call Config_Server_Setup.bat
ping -n 90 127.0.0.1 > nul
start "Mongos Query Browser" mongo %IP%:27017/admin two_add_shard.js --shell
goto SELECTION

:THREE_SHARD
call first_setup_replica.bat
ping -n 10 127.0.0.1 > nul
call second_setup_replica.bat
ping -n 20 127.0.0.1 > nul
call third_setup_replica.bat
ping -n 30 127.0.0.1 > nul
call Config_Server_Setup.bat
ping -n 90 127.0.0.1 > nul
start "Mongos Query Browser" mongo %IP%:27017/admin three_add_shard.js --shell
goto SELECTION

:END
ping -n 2 127.0.0.1 > nul
rem call Setup_Replica.bat
rem ping -n 20 127.0.0.1 > nul

rem echo "Sharding setup Done..."

