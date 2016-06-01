@ECHO OFF
REM Ustanovka lokalnyh peremennyh:
REM ARHPATH - Katalog, v kotorom sozdaetsa ishodnyj arhiv
REM OLDPATH - Katalog, v kotorom hraniatsa starye kopii
REM LEVEL - Skolko kopij arhiva hranit'
REM START, STEP, END - Ispolzujutsa v tsikle peremesh'enija arhivov po katalogam
REM NOW - Chast segodnjashnej daty, ispolzuetsa v imeni arhiva
REM ARHIV - imja arhiva
SETLOCAL
SET ARHPATH=e:\Arhiv
SET OLDPATH=e:\Arhiv\old
SET LEVEL=14
SET /a START=%LEVEL%-1
SET STEP=-1
SET END=1
SET NOW=%DATE:~-4%%DATE:~3,2%%DATE:~0,2%
SET ARHIV=AskarovPlitka_%NOW%-*.rar

REM Esli svezhego arhiva ne najdeno, to rotatsiju ne delaem, hranim starye arhivy
IF NOT EXIST %ARHPATH%\%ARHIV% GOTO END

REM Sozdaem katalogi dlja hranenija arhivov, esli ih net. Pri pervom zapuske tocno nado.
FOR /L %%n IN (%LEVEL%,%STEP%,%END%) DO (
   IF NOT EXIST %OLDPATH%\%%n\nul MD %OLDPATH%\%%n
)

REM Udaljaem samyj staryj arhiv
DEL /Q %OLDPATH%\%LEVEL%\*.*

REM V tsikle dvigaem starye arhivy po derevu katalogov
REM Dlja peremeshenija arhivov ispolzuetsa "funktsija" :MOVEMENT
FOR /L %%n IN (%START%,%STEP%,%END%) DO CALL :MOVEMENT %%n

REM Peremeshenie svezhego arhiva na 1 uroven' hranenija
MOVE /Y %ARHPATH%\%ARHIV% %OLDPATH%\1
GOTO END

:MOVEMENT
SET FROM=%1
SET /a TO=%1+1
MOVE /Y %OLDPATH%\%FROM%\*.* %OLDPATH%\%TO%\
EXIT /b

:END