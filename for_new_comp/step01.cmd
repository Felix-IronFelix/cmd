@ECHO OFF

IF "%1" EQU "" (
   ECHO Нужен входной параметр - новое имя компьютера!
   ECHO Наберите в командной строке step01.cmd computername
   PAUSE
   ) ELSE (
   COPY D:\program\cmd\step02.cmd "c:\Documents and Settings\All Users\Главное меню\Программы\Автозагрузка\"
   ECHO Сейчас будет запущена программа NewSID, которая изменит имя компьютера
   ECHO Затем КОМПЬЮТЕР БУДЕТ АВТОМАТИЧЕСКИ ПЕРЕЗАГРУЖЕН!
   PAUSE
   CALL D:\program\cmd\cleaner.cmd
   D:\program\cmd\NEWSID.EXE /a /d 10 %1
 )

 :END