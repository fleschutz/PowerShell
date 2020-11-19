#!/snap/bin/powershell

# Syntax:	./weather-worldwide.ps1
# Description:	prints the current weather of cities world-wide
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0
 
$Cities="Hawaii","Los Angeles","Mexico City","Miami","New York","Rio de Janeiro","Paris","London","Berlin","Cape Town","Dubai","Mumbai","Singapore","Hong Kong","Peking","Tokyo","Sydney"

try {
	write-host "Weather Report World-wide"
	write-host "========================="
	foreach($City in $Cities) {
		(Invoke-WebRequest http://wttr.in/${City}?format="* %l:+%c+%t+%p+%h+%P+%w +%S ->+%s" -UserAgent "curl" ).Content
	}
	exit 0
} catch { Write-Error $Error[0] }
exit 1
