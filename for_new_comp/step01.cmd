@ECHO OFF

IF "%1" EQU "" (
   ECHO �㦥� �室��� ��ࠬ��� - ����� ��� ��������!
   ECHO ������ � ��������� ��ப� step01.cmd computername
   PAUSE
   ) ELSE (
   COPY D:\program\cmd\step02.cmd "c:\Documents and Settings\All Users\������� ����\�ணࠬ��\��⮧���㧪�\"
   ECHO ����� �㤥� ����饭� �ணࠬ�� NewSID, ����� ������� ��� ��������
   ECHO ��⥬ ��������� ����� ������������� ������������!
   PAUSE
   CALL D:\program\cmd\cleaner.cmd
   D:\program\cmd\NEWSID.EXE /a /d 10 %1
 )

 :END