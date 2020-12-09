#!/snap/bin/powershell

# Syntax:	./list-modules.ps1 
# Description:	lists all PowerShell modules
# Author: 	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

try {
	Get-Module
	exit 0
} catch {
	Write-Error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
