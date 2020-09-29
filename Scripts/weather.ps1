#!/snap/bin/powershell
#
# Syntax:	./weather.ps1
# Description:	prints the current weather forecast
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0
 
$GeoLocation="" # empty means determine automatically
(Invoke-WebRequest http://wttr.in/$GeoLocation -UserAgent "curl" ).Content
exit 0
