runas /user:Администратор /savecred "NET LOCALGROUP Администраторы %username% /add"
runas /user:Администратор /savecred "NET LOCALGROUP Пользователи %username% /delete"
runas /user:Администратор /savecred "shutdown -r -t 10"