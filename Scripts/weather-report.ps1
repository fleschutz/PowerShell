#!/snap/bin/powershell

# Syntax:	./weather-report.ps1
# Description:	prints the local weather report 
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0
 
$GeoLocation="" # empty means determine automatically

try {
	(Invoke-WebRequest http://v2d.wttr.in/$GeoLocation -UserAgent "curl" ).Content
	exit 0
} catch { Write-Error $Error[0] }
exit 1
