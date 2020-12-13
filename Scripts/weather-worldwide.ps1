#!/snap/bin/powershell

# Syntax:	./weather-worldwide.ps1
# Description:	prints the current weather of cities world-wide
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0
 
$Cities="Hawaii","Los Angeles","Mexico City","Miami","New York","Rio de Janeiro","Paris","London","Berlin","Cape Town","Dubai","Mumbai","Singapore","Hong Kong","Peking","Tokyo","Sydney"

try {
	write-output "Current Weather Report World-wide"
	write-output "================================="
	write-output ""
	foreach($City in $Cities) {
		$Line = (Invoke-WebRequest http://wttr.in/${City}?format="%l:+%c+%t+%p+%h+%P+%w +%S ->+%s" -UserAgent "curl").Content
		write-output "* $Line"
	}
	write-output ""
	exit 0
} catch {
	Write-Error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
