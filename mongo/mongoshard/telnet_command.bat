@echo off
SET /a i=0
:loop
IF %i%==10 GOTO END
echo This is iteration %i%.
SET /a i=%i%+1
GOTO LOOP
:end

pause
 
