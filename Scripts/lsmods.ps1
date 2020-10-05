#!/snap/bin/powershell
#
# Syntax:	./lsmods.ps1 
# Description:	lists all PowerShell modules
# Author: 	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

try {
	Get-Module
	exit 0
} catch { Write-Error $Error[0] }
exit 1
