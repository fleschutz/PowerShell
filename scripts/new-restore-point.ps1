<#
.SYNOPSIS
	Creates a restore point
.DESCRIPTION
	This PowerShell script creates a new system restore point on the local computer.
.EXAMPLE
	PS> ./new-restore-point.ps1 
	✅ Restore point created.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1 -RunAsAdministrator

param([string]$description = "by new-restore-point.ps1")

try {
	Checkpoint-Computer -Description $description -RestorePointType MODIFY_SETTINGS
	if ($lastExitCode -ne 0) { throw "Executing Checkpoint-Computer has failed with exit code $lastExitCode" }

	"✅ Restore point created."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (in script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
