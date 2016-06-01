REM @ECHO OFF
SETLOCAL

REM ”становка буквы сетевого диска в зависимости от параметра %1
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

REM ≈сли введены неправильные параметры (то есть не совпали ни с одним IF)  - сообщение об ошибке и выход
ECHO Please enter correct parameters
PAUSE
GOTO END

:OFF
IF EXIST %DRIVE%\nul NET USE %DRIVE% /d /y
GOTO END


:END