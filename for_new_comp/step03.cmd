@ECHO OFF

IF NOT EXIST D:\home\nul MD D:\home
IF NOT EXIST "D:\home\%username%\nul" MD "D:\home\%username%"
IF NOT EXIST "D:\home\%username%\��� ���㬥���\nul" MD "D:\home\%username%\��� ���㬥���"
IF NOT EXIST "D:\home\%username%\����稩 �⮫\nul" MD "D:\home\%username%\����稩 �⮫"

XCOPY "%userprofile%\��� ���㬥���\*.*" "D:\home\%username%\��� ���㬥���\" /E /H
XCOPY "%userprofile%\����稩 �⮫\*.*" "D:\home\%username%\����稩 �⮫\" /E /H

ECHO Windows Registry Editor Version 5.00 > d:\program\cmd\userfolders.reg
ECHO. >> d:\program\cmd\userfolders.reg
ECHO [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders] >> d:\program\cmd\userfolders.reg
ECHO "Desktop"="D:\\home\\%username%\\������� ����" >> d:\program\cmd\userfolders.reg
ECHO "Personal"="D:\\home\\%username%\\��� ���������">> d:\program\cmd\userfolders.reg

regedit /d d:\program\cmd\userfolders.reg

NET USER user /delete
RD /S /Q D:\home\user
RD /S /Q c:\Documents and Settings\User

shutdown -r -f -t 10 -c "Reboot after 10 sec"

COPY D:\program\cmd\step04.cmd "c:\Documents and Settings\All Users\������� ����\�ணࠬ��\��⮧���㧪�\"
DEL "c:\Documents and Settings\All Users\������� ����\�ணࠬ��\��⮧���㧪�\step03.cmd"



:END