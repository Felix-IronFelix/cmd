@ECHO OFF

IF NOT EXIST D:\home\nul MD D:\home
IF NOT EXIST "D:\home\%username%\nul" MD "D:\home\%username%"
IF NOT EXIST "D:\home\%username%\Мои документы\nul" MD "D:\home\%username%\Мои документы"
IF NOT EXIST "D:\home\%username%\Рабочий стол\nul" MD "D:\home\%username%\Рабочий стол"

ECHO Windows Registry Editor Version 5.00 > d:\program\cmd\userfolders.reg
ECHO. >> d:\program\cmd\userfolders.reg
ECHO [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders] >> d:\program\cmd\userfolders.reg
ECHO "Desktop"="D:\\home\\%username%\\╨рсюўшщ ёЄюы" >> d:\program\cmd\userfolders.reg
ECHO "Personal"="D:\\home\\%username%\\╠юш фюъєьхэЄ√">> d:\program\cmd\userfolders.reg

regedit /d d:\program\cmd\userfolders.reg