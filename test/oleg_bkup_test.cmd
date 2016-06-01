
@ECHO OFF

REM Установка локальных переменных
SETLOCAL
REM Каталог, в котором будет храниться архив
SET ARCHPATH=d:\arhiv\test

REM Установка количества попыток подключения сетевого диска
SET TRY=20

REM Подключение сетевого диска
:CONNECT
NET USE Z: /d /y
FOR /L %%N IN (1,1,%TRY%) DO (
   IF NOT EXIST Z:\nul (
      NET USE Z: \\192.168.0.1\backup\oleg /user:bkup bkup /persistent:no
   ) ELSE (
      GOTO EXIT01
   )
)
:EXIT01

REM Синхронизация локального каталога с сетевым
%~dp0\robocopy %ARCHPATH% Y:\oleg /MIR /R:100 /W:5 /TBD

REM Отключение сетевого диска
REM NET USE Y: /d /y


:END