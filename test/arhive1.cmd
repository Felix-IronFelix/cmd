@ECHO OFF

SETLOCAL
REM ��������� ����������
REM �������, � ������� ����� ��������� �����:
SET ARCHPATH=D:\arhiv
REM ������� ��� �������� ������ ����� ������:
SET OLDPATH=%ARCHPATH%\old
REM ������� ���� ������� ������ (������� ��������):
SET LEVEL=14
REM ������������ ��� ������� ������ ������ �� ������ ���������
SET /a START=%LEVEL%-1
SET STEP=-1
SET END=1

REM ������� ����� ������ (� ����)
REM %1 - ��� ������������ ���� (Stroy, Plitka ��� ����� ������)
REM ��������� ��� ������ �� ��������� ����� arhive.cmd,
REM ���� � ����� ����� ��������� ��� �������� ������:
SET ARCHNAME=%ARCHPATH%\%1_
REM �������� �� ���������� ������, � �������������� ���������� RAR
REM SET ERRLOG=%ARCHPATH%\%1_errlog.log
REM ���� ����:
SET LOG=%ARCHPATH%\%1_log.log
REM ������������ ��������� � ����������� ������:
SET PROGPATH=D:\Temp\3\cmd
REM ����-������ ���-������. ������������ � ������� :LOGROTATION
SET REN_LIST=%PROGPATH%\ren_list.txt
REM ������������ ����������:
SET ZIP="%PROGPATH%\7-ZipPortable\App\7-Zip\7z.exe"
REM ������������ �����-������ ��� ���������
SET LIST=%PROGPATH%\%1_list.txt
REM ������������ �����-������ ���������� ��� ���������
SET XLIST=%PROGPATH%\%1_xlist.txt
REM ������������ ����������, ���������� ����� � ����
REM ����� ��� ���������� ������� � �������
SET NOW=%DATE:~-4%%DATE:~3,2%%DATE:~0,2%
SET DAY=%DATE:~0,2%
SET /a DAY_BEGIN=%DAY%-1
SET DATE_BEGIN=%DATE:~-4%%DATE:~3,2%%DAY_BEGIN%
REM ���������� TIMESTAMP ���������� ����������, �������� �������
REM � �������� ����, ����� ������������ ���������� ���� (04:30, ��������),
REM �� ����� ���� ������������� ������ ( 4:30).
REM ������� ���������� ��� ��������� �, ��� �������������, �����������
REM ���� ���� ��������������.
SET UTRO=%TIME:~0,1%
IF "%UTRO%" == " " (
   SET TIMESTAMP=%DATE:~-4%%DATE:~3,2%%DATE:~0,2%-0%TIME:~1,1%%TIME:~3,2%
) ELSE (
   SET TIMESTAMP=%DATE:~-4%%DATE:~3,2%%DATE:~0,2%-%TIME:~0,2%%TIME:~3,2%
)
REM ��������� ���������� ��� ������ ������� ���������� �� ��. �����:
SET BLAT=%PROGPATH%\blat307\full\blat.exe
SET BLAT_FILES=%PROGPATH%\blat307\files
SET MAILLIST=%BLAT_FILES%\maillist.txt
SET SMTPSENDER=name@yandex.ru 
SET SMTPSERVER=smtp.yandex.ru 
SET SMTPPORT=25 
SET SMTPUSER=name@yandex.ru 
SET SMTPPWD=password
SET CODEPAGE=Windows-1251
REM ������� �� �������, � ������� ����� ��������� ������:
SET PATH_ON_SERVER=krist\askarov

ECHO ========================== >> %LOG%
ECHO Start backup at >> %LOG%
DATE /T >> %LOG%
TIME /T >> %LOG%



REM CALL %PROGPATH%\disk_z_connect.cmd
REM ������ ������ ���������� cmd-�����, ������� ��� ����:
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

REM ������� �������
REM ���� ������ �� ���������� ���� �� �������, �� ������� �� �����������.
REM ����� �������, ���� �� �����-�� ������� ����� ������ �� ���������,
REM �� ������ ������ �� �������:
IF NOT EXIST %ARCHNAME%%DATE_BEGIN%-*.* GOTO END
REM ������ �������� ��� �������� �������, ���� �� ���. ��� ������ ������� ����� ����:
FOR /L %%n IN (%LEVEL%,%STEP%,%END%) DO (
   IF NOT EXIST %OLDPATH%\%%n\nul MD %OLDPATH%\%%n
)
REM ������� ����� ������ ����� �� �������� ������� ������ ��������:
DEL /Q %OLDPATH%\%LEVEL%\*.*
REM � ����� ������� ������ ������ �� ������ ���������
REM ��� ����������� ������� ������������ "�������" :ROTATION
FOR /L %%n IN (%START%,%STEP%,%END%) DO CALL :ROTATION %%n
REM ����������� ������ �� ���������� �� 1 ������� ��������:
MOVE /Y %ARCHNAME%%DATE_BEGIN%-*.* %OLDPATH%\1


REM ������� �����
REM ����������� ������ �� ������ ������ ������
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