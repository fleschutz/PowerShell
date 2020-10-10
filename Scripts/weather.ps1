#!/snap/bin/powershell

# Syntax:	./weather.ps1
# Description:	prints the current weather forecast
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0
 
$GeoLocation="" # empty means determine automatically

try {
	(Invoke-WebRequest http://wttr.in/$GeoLocation -UserAgent "curl" ).Content
	exit 0
} catch { Write-Error $Error[0] }
exit 1
