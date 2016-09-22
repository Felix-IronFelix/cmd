@ECHO OFF

SETLOCAL
SET APP_LIST=%~dp0\app_list.txt


FOR /F "tokens=1,2 delims=;" %%i in (%APP_LIST%) DO (
ping -n %%i 127.0.0.1 2>&1>NUL
START "" %%j
)

:END
