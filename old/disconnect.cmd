REM @ECHO OFF
SETLOCAL

REM ��������� ����� �������� ����� � ����������� �� ��������� %1
IF %1 EQU install (
    SET DRIVE=Z:
	GOTO OFF
	)
IF %1 EQU distr (
	SET DRIVE=Z:
	GOTO OFF
	)
IF %1 EQU oleg (
	SET DRIVE=O:
    GOTO OFF
	)
IF %1 EQU it (
    SET %DRIVE%=Y:
	GOTO OFF
	)

REM ���� ������� ������������ ��������� (�� ���� �� ������� �� � ����� IF)  - ��������� �� ������ � �����
ECHO Please enter correct parameters
PAUSE
GOTO END

:OFF
IF EXIST %DRIVE%\nul NET USE %DRIVE% /d /y
GOTO END


:END