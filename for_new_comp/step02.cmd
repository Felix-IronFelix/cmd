@ECHO OFF

ECHO ����� �㤥� ᮧ��� ���� ���짮��⥫�
ECHO.
ECHO � ������  %computername%-user ��஫�� 123
ECHO.
ECHO � ��������� ����� ������������!
ECHO.
ECHO ��⥬ �㦭� �㤥� ���� � ��⥬� ��� ���짮��⥫� %computername%-user
ECHO.
ECHO � ���쭥�訥 ����⢨� �ந������� �� ��� �����.
PAUSE

NET USER %computername%-user 123 /add /passwordchg:no /expires:never
NET LOCALGROUP ������������ %computername%-user  /add
NET LOCALGROUP ���짮��⥫� %computername%-user  /delete
WMIC UserAccount WHERE Name="%computername%-user" Set PasswordExpires=FALSE

SHUTDOWN -r -f -t 10 -c "Reboot after 10 sec"

COPY D:\program\cmd\step03.cmd "c:\Documents and Settings\All Users\������� ����\�ணࠬ��\��⮧���㧪�\"
DEL "c:\Documents and Settings\All Users\������� ����\�ணࠬ��\��⮧���㧪�\step02.cmd"

:END