@ECHO OFF

IF NOT EXIST D:\home\nul MD D:\home
IF NOT EXIST "D:\home\%username%\nul" MD "D:\home\%username%"
IF NOT EXIST "D:\home\%username%\��� ���㬥���\nul" MD "D:\home\%username%\��� ���㬥���"
IF NOT EXIST "D:\home\%username%\����稩 �⮫\nul" MD "D:\home\%username%\����稩 �⮫"

ECHO Windows Registry Editor Version 5.00 > d:\program\cmd\userfolders.reg
ECHO. >> d:\program\cmd\userfolders.reg
ECHO [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders] >> d:\program\cmd\userfolders.reg
ECHO "Desktop"="D:\\home\\%username%\\������� ����" >> d:\program\cmd\userfolders.reg
ECHO "Personal"="D:\\home\\%username%\\��� ���������">> d:\program\cmd\userfolders.reg

regedit /d d:\program\cmd\userfolders.reg