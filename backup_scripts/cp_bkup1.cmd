REM ���� ���� ����������� ����� ���������� ������ ������������ ���������� Cobian Backup
REM �� ����� ��� ����������� �������� ����� � ������������� ������ � ��������� � ������� ���������

@ECHO OFF

REM ��������� ��������� ���������� ����������� � ����� cp_bkup.cmd
REM �� �������� � ���������� ���� ������


REM ����������� �������� �����
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

REM ������������� ���������� �������� � �������
%~dp0\robocopy %ARCHPATH% %DRIVELETTER% /MIR /R:100 /W:5 /TBD

REM ���������� �������� �����
NET USE %DRIVELETTER% /d /y

:END