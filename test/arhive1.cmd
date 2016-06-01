@ECHO OFF

SETLOCAL
REM Установка переменных
REM Каталог, в котором будет храниться архив:
SET ARCHPATH=D:\arhiv
REM Каталог для хранения старых копий архива:
SET OLDPATH=%ARCHPATH%\old
REM Сколько дней хранить архивы (уровень хранения):
SET LEVEL=14
REM Используются при ротации файлов архива по дереву каталогов
SET /a START=%LEVEL%-1
SET STEP=-1
SET END=1

REM Префикс имени архива (с путём)
REM %1 - имя архивируемой базы (Stroy, Plitka или любое другое)
REM передаётся при вызове из головного файла arhive.cmd,
REM дата и время будут добавлены при создании архива:
SET ARCHNAME=%ARCHPATH%\%1_
REM Осталось от предыдущей версии, с использованием архиватора RAR
REM SET ERRLOG=%ARCHPATH%\%1_errlog.log
REM Файл лога:
SET LOG=%ARCHPATH%\%1_log.log
REM Расположение командных и программных файлов:
SET PROGPATH=D:\Temp\3\cmd
REM Файл-список лог-файлов. Используется в функции :LOGROTATION
SET REN_LIST=%PROGPATH%\ren_list.txt
REM Расположение архиватора:
SET ZIP="%PROGPATH%\7-ZipPortable\App\7-Zip\7z.exe"
REM Расположение файла-списка для архивации
SET LIST=%PROGPATH%\%1_list.txt
REM Расположение файла-списка исключений для архивации
SET XLIST=%PROGPATH%\%1_xlist.txt
REM Формирование переменных, содержащих время и дату
REM Нужно для именования архивов и ротации
SET NOW=%DATE:~-4%%DATE:~3,2%%DATE:~0,2%
SET DAY=%DATE:~0,2%
SET /a DAY_BEGIN=%DAY%-1
SET DATE_BEGIN=%DATE:~-4%%DATE:~3,2%%DAY_BEGIN%
REM Переменную TIMESTAMP приходится выставлять, проверяя условие
REM В утренние часы, когда присутствует лидирующий ноль (04:30, например),
REM на самом деле подставляется пробел ( 4:30).
REM Поэтому приходится это проверять и, при необходимости, подставлять
REM этот ноль самостоятельно.
SET UTRO=%TIME:~0,1%
IF "%UTRO%" == " " (
   SET TIMESTAMP=%DATE:~-4%%DATE:~3,2%%DATE:~0,2%-0%TIME:~1,1%%TIME:~3,2%
) ELSE (
   SET TIMESTAMP=%DATE:~-4%%DATE:~3,2%%DATE:~0,2%-%TIME:~0,2%%TIME:~3,2%
)
REM Установка переменных для работы системы оповещения оп эл. почте:
SET BLAT=%PROGPATH%\blat307\full\blat.exe
SET BLAT_FILES=%PROGPATH%\blat307\files
SET MAILLIST=%BLAT_FILES%\maillist.txt
SET SMTPSENDER=name@yandex.ru 
SET SMTPSERVER=smtp.yandex.ru 
SET SMTPPORT=25 
SET SMTPUSER=name@yandex.ru 
SET SMTPPWD=password
SET CODEPAGE=Windows-1251
REM Каталог на сервере, в котором будут храниться архивы:
SET PATH_ON_SERVER=krist\askarov

ECHO ========================== >> %LOG%
ECHO Start backup at >> %LOG%
DATE /T >> %LOG%
TIME /T >> %LOG%



REM CALL %PROGPATH%\disk_z_connect.cmd
REM Вместо вызова отдельного cmd-файла, вставим код сюда:
IF NOT EXIST Z:\nul (
   NET USE Z: \\192.168.0.1\backup\%PATH_ON_SERVER% /user:bkup bkup /persistent:no
   ECHO Disk Z: connected sucsessfully! >> %log%
) ELSE (
   ECHO Disk Z: already connected! >> %log%
)

%ZIP% a -r -t7z -x@%XLIST% %ARCHNAME%%TIMESTAMP%.7z @%LIST%

XCOPY /Q /H /Z /Y "%ARCHNAME%%NOW%-*.*" Z:\ >> %LOG%

Z:
CD \
CD Z:\
IF EXIST "%1_%NOW%-*.7z" (
   ECHO File exist
   CALL :SENDMSG %BLAT_FILES%\%1_subj.txt %BLAT_FILES%\%1_message.txt
) ELSE (
   ECHO File not exist
   CALL :SENDMSG %BLAT_FILES%\%1_err_subj.txt %BLAT_FILES%\%1_err_message.txt
)

ECHO End backup at >> %LOG%
DATE /T >> %LOG%
TIME /T >> %LOG%

REM Ротация архивов
REM Если архива за предыдущий день не найдено, то ротация не выполняется.
REM Таким образом, если по какой-то причине новые архивы не создаются,
REM то старые никуда не денутся:
IF NOT EXIST %ARCHNAME%%DATE_BEGIN%-*.* GOTO END
REM Создаём каталоги для хранения архивов, если их нет. При первом запуске точно надо:
FOR /L %%n IN (%LEVEL%,%STEP%,%END%) DO (
   IF NOT EXIST %OLDPATH%\%%n\nul MD %OLDPATH%\%%n
)
REM Удаляем самый старый архив из каталога нижнего уровня хранения:
DEL /Q %OLDPATH%\%LEVEL%\*.*
REM В цикле двигаем старые архивы по дереву каталогов
REM Для перемещения архивов используется "функция" :ROTATION
FOR /L %%n IN (%START%,%STEP%,%END%) DO CALL :ROTATION %%n
REM Перемещение архива за предыдущий на 1 уровень хранения:
MOVE /Y %ARCHNAME%%DATE_BEGIN%-*.* %OLDPATH%\1


REM Ротация логов
REM Запускается только по первым числам месяца
IF %DAY% == 01 CALL :LOGROTATION



GOTO END

REM =========== FUNCTIONS ============

REM ===== Begin SENDMSG function =====
:SENDMSG
SET SUBJ=%1
SET MSG=%2

for /f %%f in ('type %MAILLIST%') do %BLAT% -to %%f -f %SMTPSENDER% -server %SMTPSERVER% -port %SMTPPORT% -u %SMTPUSER% -pw %SMTPPWD% -log %log% -charset %CODEPAGE% -sf %SUBJ% -bodyF %MSG%

EXIT /b
REM ===== End SENDMSG function =====


REM ===== Begin ROTATION function =====
:ROTATION
SET FROM=%1
SET /a TO=%1+1
MOVE /Y %OLDPATH%\%FROM%\*.* %OLDPATH%\%TO%\
EXIT /b
REM ===== End ROTATION function =====

REM ===== Begin LOGROTATION function =====
:LOGROTATION
IF NOT EXIST %LOG% EXIT /b
ECHO %LOG% > %REN_LIST%
FOR /F %%f in ('TYPE %REN_LIST%') DO (
IF EXIST %%f.bak DEL %%f.bak
IF EXIST %%f REN %%f %%~nxf.bak
)
EXIT /b
REM ===== End LOGROTATION function =====

REM =========== END FUNCTIONS ============

:END