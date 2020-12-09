#!/snap/bin/powershell

# Syntax:	./moon.ps1
# Description:	prints the current moon phase
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0
 
try {
	(Invoke-WebRequest http://wttr.in/Moon -UserAgent "curl" ).Content
	exit 0
} catch {
	Write-Error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
