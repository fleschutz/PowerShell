<#
.SYNOPSIS
	Lists restore points
.DESCRIPTION
	This PowerShell script lists the system restore points of the local computer.
.EXAMPLE
	PS> ./list-restore-points.ps1 
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1 -RunAsAdministrator

try {
	Get-ComputerRestorePoint
	if ($lastExitCode -ne 0) { throw "Executing Get-ComputerRestorePoint has failed with exit code $lastExitCode" }

	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (in script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
