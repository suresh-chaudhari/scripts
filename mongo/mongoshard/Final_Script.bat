@echo off

call Setup_Replica.bat
ping -n 20 127.0.0.1 > nul
call Config_Server_Setup.bat
echo "Sharding setup Done..."