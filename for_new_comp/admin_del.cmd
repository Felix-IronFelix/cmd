runas /user:Администратор /savecred "NET LOCALGROUP Администраторы %username% /delete"
runas /user:Администратор /savecred "NET LOCALGROUP Пользователи %username% /add"
runas /user:Администратор /savecred "shutdown -r -t 10"