REM Этот файл запускается после архивациии данных пользователя программой Cobian Backup
REM Он нужен для подключения сетевого диска и синхронизации файлов в локальном и сетевом каталогах

@ECHO OFF

REM Установка локальных переменных выполняется в файле cp_bkup.cmd
REM из которого и вызывается этот скрипт


REM Подключение сетевого диска
:CONNECT
NET USE %DRIVELETTER% /d /y
FOR /L %%N IN (1,1,%TRY%) DO (
   IF NOT EXIST %DRIVELETTER%\nul (
      NET USE %DRIVELETTER% %SERVPATH% /user:%USERNAME% %PASS% /persistent:no
   ) ELSE (
      GOTO EXIT01
   )
)
:EXIT01

REM Синхронизация локального каталога с сетевым
%~dp0\robocopy %ARCHPATH% %DRIVELETTER% /MIR /R:100 /W:5 /TBD

REM Отключение сетевого диска
NET USE %DRIVELETTER% /d /y

:END