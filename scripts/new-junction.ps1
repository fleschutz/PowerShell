<#
.SYNOPSIS
	Create a junction
.DESCRIPTION
	This PowerShell script creates a new junction, linking to a target folder. The target folder can reside on another disk.
.PARAMETER junction
	Specifies the path and filename of the new junction
.PARAMETER targetDir
	Specifies the path to the target directory
.EXAMPLE
	PS> ./new-junction.ps1 C:\User\Joe\D_drive D:
	✅ New junction 'C:\User\Joe\D_drive' created, linking to: 📂D:
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$junction = "", [string]$targetDir = "")

try {
	if ($junction -eq "" ) { $junction = Read-Host "Enter the new junction's path and filename" }
	if ($targetDir -eq "" ) { $target = Read-Host "Enter the path to the target directory    " }

	New-Item -path "$junction" -itemType Junction -value "$targetDir"
	if ($lastExitCode -ne 0) { throw "Command 'New-Item' has failed" }

	"✅ New junction '$junction' created, linking to: 📂$targetDir"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
