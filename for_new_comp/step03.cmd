@ECHO OFF

IF NOT EXIST D:\home\nul MD D:\home
IF NOT EXIST "D:\home\%username%\nul" MD "D:\home\%username%"
IF NOT EXIST "D:\home\%username%\Мои документы\nul" MD "D:\home\%username%\Мои документы"
IF NOT EXIST "D:\home\%username%\Рабочий стол\nul" MD "D:\home\%username%\Рабочий стол"

XCOPY "%userprofile%\Мои документы\*.*" "D:\home\%username%\Мои документы\" /E /H
XCOPY "%userprofile%\Рабочий стол\*.*" "D:\home\%username%\Рабочий стол\" /E /H

ECHO Windows Registry Editor Version 5.00 > d:\program\cmd\userfolders.reg
ECHO. >> d:\program\cmd\userfolders.reg
ECHO [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders] >> d:\program\cmd\userfolders.reg
ECHO "Desktop"="D:\\home\\%username%\\╨рсюўшщ ёЄюы" >> d:\program\cmd\userfolders.reg
ECHO "Personal"="D:\\home\\%username%\\╠юш фюъєьхэЄ√">> d:\program\cmd\userfolders.reg

regedit /d d:\program\cmd\userfolders.reg

NET USER user /delete
RD /S /Q D:\home\user
RD /S /Q c:\Documents and Settings\User

shutdown -r -f -t 10 -c "Reboot after 10 sec"

COPY D:\program\cmd\step04.cmd "c:\Documents and Settings\All Users\Главное меню\Программы\Автозагрузка\"
DEL "c:\Documents and Settings\All Users\Главное меню\Программы\Автозагрузка\step03.cmd"



:END