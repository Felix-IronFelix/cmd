@ECHO OFF

ECHO Сейчас будет создан новый пользователь
ECHO.
ECHO с именем  %computername%-user паролем 123
ECHO.
ECHO и КОМПЬЮТЕР БУДЕТ ПЕРЕЗАГРУЖЕН!
ECHO.
ECHO Затем нужно будет войти в систему как пользователь %computername%-user
ECHO.
ECHO и дальнейшие действия производить от его имени.
PAUSE

NET USER %computername%-user 123 /add /passwordchg:no /expires:never
NET LOCALGROUP Администраторы %computername%-user  /add
NET LOCALGROUP Пользователи %computername%-user  /delete
WMIC UserAccount WHERE Name="%computername%-user" Set PasswordExpires=FALSE

SHUTDOWN -r -f -t 10 -c "Reboot after 10 sec"

COPY D:\program\cmd\step03.cmd "c:\Documents and Settings\All Users\Главное меню\Программы\Автозагрузка\"
DEL "c:\Documents and Settings\All Users\Главное меню\Программы\Автозагрузка\step02.cmd"

:END