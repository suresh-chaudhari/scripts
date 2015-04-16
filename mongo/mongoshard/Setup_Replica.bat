@echo off

call first_setup_replica.bat
ping -n 10 127.0.0.1 > nul
call second_setup_replica.bat
ping -n 10 127.0.0.1 > nul
rem call third_setup_replica.bat

