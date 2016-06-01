@ECHO OFF

SETLOCAL
SET ren_list=d:\Temp\4\ren_list.txt

FOR /F %%f in ('TYPE %ren_list%') DO (
IF NOT EXIST %%f GOTO END
IF EXIST %%f.bak DEL %%f.bak
IF EXIST %%f REN %%f %%~nxf.bak
)

:END