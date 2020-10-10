#!/snap/bin/powershell
#
# Syntax:	./list-cmdlets.ps1 
# Description:	lists all PowerShell cmdlets
# Author: 	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

try {
	Get-Command -Command-Type cmdlet
	exit 0
} catch { Write-Error $Error[0] }
exit 1
