REM This is example script, passwords and IP not real

@ECHO OFF
SETLOCAL

REM ѕроверка подключенных сетевых дисков, если есть - вывести сообщение и выйти
IF EXIST Z:\nul (
	SET DRIVE=Z:
	GOTO ERROR1
	)
IF EXIST O:\nul (
	SET DRIVE=O:
	GOTO ERROR1
	)
IF EXIST Y:\nul (
	SET DRIVE=Y:
	GOTO ERROR1
	)

REM ”становка буквы сетевого диска в зависимости от параметра %1
IF %1 EQU install (
    SET DRIVE=Z:
	GOTO INSTALL
	)
IF %1 EQU distr (
	SET DRIVE=Z:
	GOTO DISTR
	)
IF %1 EQU oleg (
	SET DRIVE=O:
    GOTO OLEG
	)
IF %1 EQU it (
    SET %DRIVE%=Y:
	GOTO IT
	)

REM ≈сли введены неправильные параметры (то есть не совпали ни с одним IF)  - сообщение об ошибке и выход
ECHO Please enter correct parameters
PAUSE
GOTO END

REM ”становка переменных в зависимости от входных параметров
:INSTALL
SET DIRECTORY=distr
SET USERNAME=install
SET PASSWORD=install
GOTO CONNECT

:DISTR
SET DIRECTORY=distr
SET USERNAME=distr
SET PASSWORD=distr
GOTO CONNECT

:OLEG
SET DIRECTORY=oleg_bkup
SET USERNAME=oleg
SET PASSWORD=password
GOTO CONNECT

:IT
SET DIRECTORY=it
SET USERNAME=it
SET PASSWORD=password
GOTO CONNECT

REM ѕодключение сетевого диска с использованием выше установленных переменных
:CONNECT
NET USE %DRIVE% \\192.168.0.1\%DIRECTORY% /user:%USERNAME% %PASSWORD% /persistent:no
START C:\totalcmd\totalcmd.exe %DRIVE%\
GOTO END

:ERROR1
ECHO Drive %DRIVE% already connected.
ECHO Please close any documents at drive %DRIVE%, disconnect it and try again.
PAUSE
GOTO END

:END