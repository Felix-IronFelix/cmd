@ECHO OFF
IF NOT EXIST Z:\nul (
   NET USE Z: \\192.168.0.1\backup\krist\askarov /user:bkup bkup /persistent:no
   ECHO ERRORLEVEL = %ERRORLEVEL%
   ECHO Disk Z: connected sucsessfully! >> %log%
) ELSE (
   ECHO Disk Z: already connected! >> %log%
)

:END
