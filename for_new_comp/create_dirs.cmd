@ECHO OFF

IF NOT ExIST D:\home\%username%\nul MD D:\home\%username%
IF NOT ExIST "D:\home\%username%\��� ���㬥���\nul" MD "D:\home\%username%\��� ���㬥���"
IF NOT ExIST "D:\home\%username%\����稩 �⮫\nul" MD "D:\home\%username%\����稩 �⮫"

IF ExIST D:\home\user\nul RD /S /Q D:\home\user

