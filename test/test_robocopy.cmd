IF NOT EXIST Y:\nul NET USE Y: \\192.168.0.1\it /user:it password /persistent:no

robocopy d:\Temp\Krist_1C\KioskOS Y:\test_robocopy /E /Z /R:200 /TBD