@ECHO OFF

SETLOCAL
REM Файл лога:
SET LOG=%~dp0\Avira.log

REM Поиск в запущенных процессах процесса, который отвечает за запуск рекламного объявления
REM и его прекращение
set filename=ipmgui.exe
REM if "%1" neq "" set filename=%1

for /f %%a in ('tasklist /nh /fi "imagename eq %filename%" ^| find /c "%filename%"') do set /a quantity=%%a
rem Если запущена 1 и более копий процесса
if %quantity% geq 1 goto ALREADY_RUN

DATE /t >> %LOG%
TIME /t >> %LOG%
echo No processes of %filename%! >> %LOG%
rem ... Вставьте сюда свои команды, когда процесс НЕ запущен ...
goto IPM

:ALREADY_RUN
DATE /t >> %LOG%
TIME /t >> %LOG%
echo Already run %quantity% processes of %filename% >> %LOG%
rem ... Вставьте сюда свои команды, когда процесс запущен ...
TASKKILL /F /IM ipmgui.exe


REM Поиск и удаление файла с рекламным объявлением
:IPM
IF EXIST C:\ProgramData\Avira\Antivirus\IPM\IpmDocument.html (
   ECHO File exist, deleted >> %LOG%
   DEL /Q /F C:\ProgramData\Avira\Antivirus\IPM\*.*
   ) ELSE (
   ECHO File not exist, well done >> %LOG%
   )

REM 25 числа каждого месяца удаляем файл лога, чтобы не рос бесконечно
SET DAY=%DATE:~0,2%

IF %DAY% == 25 (
   IF EXIST %LOG%.bak DEL %LOG%.bak
   REN %LOG% Avira.log.bak
   )
   
:END
