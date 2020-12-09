#!/snap/bin/powershell

# Syntax:	./poweroff.ps1
# Description:	halts the local computer, administrator rights are required 
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

#Requires -RunAsAdministrator
try {
	Stop-Computer
	exit 0
} catch {
	Write-Error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
