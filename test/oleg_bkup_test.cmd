
@ECHO OFF

REM ��������� ��������� ����������
SETLOCAL
REM �������, � ������� ����� ��������� �����
SET ARCHPATH=d:\arhiv\test

REM ��������� ���������� ������� ����������� �������� �����
SET TRY=20

REM ����������� �������� �����
:CONNECT
NET USE Z: /d /y
FOR /L %%N IN (1,1,%TRY%) DO (
   IF NOT EXIST Z:\nul (
      NET USE Z: \\192.168.0.1\backup\oleg /user:bkup bkup /persistent:no
   ) ELSE (
      GOTO EXIT01
   )
)
:EXIT01

REM ������������� ���������� �������� � �������
%~dp0\robocopy %ARCHPATH% Y:\oleg /MIR /R:100 /W:5 /TBD

REM ���������� �������� �����
REM NET USE Y: /d /y


:END