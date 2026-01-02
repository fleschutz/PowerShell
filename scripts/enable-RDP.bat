:: Script to enable Remote Desktop on a machine (must run locally)

:: Open the firewall to allow incoming connections
netsh advfirewall firewall set rule group="Remote Desktop" new enable=Yes

:: Disable the "Deny TS Connections" registry key
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f

:: Set the service to start automatically at boot time
sc config termservice start= auto

:: Start the service
net start termservice
