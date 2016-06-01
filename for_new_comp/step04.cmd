@ECHO OFF

ECHO Сейчас будет запущено средство управления учётными записями пользователей.
ECHO.
ECHO В открывшемся окне выберите пользователя %username%
ECHO.
ECHO Затем снимите галочку "Требовать ввод имени пользователя и пароля"
ECHO.
ECHO и нажмите ОК. Компьютер спросит пароль для этого пользователя.
ECHO.
ECHO Пароль: 123
PAUSE

control userpasswords2

DEL "c:\Documents and Settings\All Users\Главное меню\Программы\Автозагрузка\step04.cmd"

netsh -f d:\program\cmd\interface_local.txt

:END