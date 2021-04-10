### Silently installs latest google chrome ###
$Path = $env:TEMP;
$Installer = "chrome_installer.exe"
Invoke-WebRequest "http://dl.google.com/chrome/install/latest/chrome_installer.exe" -OutFile $Path\$Installer
Start-Process -FilePath $Path\$Installer -Args "/silent /install" -Verb RunAs -Wait
Remove-Item $Path\$Installer
exit 0
