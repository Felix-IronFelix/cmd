@ECHO OFF

IF NOT ExIST D:\home\%username%\nul MD D:\home\%username%
IF NOT ExIST "D:\home\%username%\Мои документы\nul" MD "D:\home\%username%\Мои документы"
IF NOT ExIST "D:\home\%username%\Рабочий стол\nul" MD "D:\home\%username%\Рабочий стол"

IF ExIST D:\home\user\nul RD /S /Q D:\home\user

