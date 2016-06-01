REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{25EE66BF-2433-4A3F-8A02-73163695FF31} /f

REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{4A3CAB56-C752-4021-9E33-373A31C41F1F} /f

REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{63726BC7-42A1-45CA-B459-31FCCD31305D} /f

REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{64B85CFF-06F0-44C4-A102-1DD238972A48} /f

REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{9CA687C0-23BB-41AD-9D4F-CEEDCCCE8E90} /f

REG DELETE HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{A69FD405-C865-4C45-98D2-086EC9595CAC} /f


RD /S /Q C:\D
RD /S /Q C:\SYSPREP

REM SHUTDOWN -r -t 15 -c "Компьютер будет перезагружен через 15 сек."