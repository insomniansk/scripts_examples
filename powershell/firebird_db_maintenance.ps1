#This script temporary blocking network connections from networks to firebird service, then making backup and restore using gbak utility.
# And permits network connection in the end of task
Stop-Service -Name FirebirdServerDefaultInstance -PassThru
# Windows 2008R2 doesn't support Firewall cmdlets of powershell. So we using netsh cmd utility to manage firewall.
netsh advfirewall firewall set rule name="Firebird_allow" new enable=no
Copy-Item -Path D:\Databases\Database.GDB -Destination D:\Databases\Broken.GDB -Force
Start-Service -Name FirebirdServerDefaultInstance -PassThru
Set-Location "C:\Program Files (x86)\Firebird\Firebird_2_5\bin"
.\gbak.exe -b "D:\Databases\Broken.GDB" "D:\Databases\Temp.FBK" -user SYSDBA -pass password
Remove-Item -Path D:\Databases\Broken.GDB
.\gbak.exe -c "D:\Databases\Temp.FBK" "D:\Databases\Repaired.GDB" -user SYSDBA -pass password
Stop-Service -Name FirebirdServerDefaultInstance -PassThru
Copy-Item -Path D:\Databases\Repaired.GDB -Destination D:\Webbases\Database.GDB -Force
Remove-Item -Path D:\Databases\Repaired.GDB
Remove-Item -Path D:\Databases\Temp.FBK
Start-Service -Name FirebirdServerDefaultInstance -PassThru
netsh advfirewall firewall set rule name="Firebird_allow" new enable=yes
