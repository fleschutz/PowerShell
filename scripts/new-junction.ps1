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
	✅ Created a new junction 'C:\User\Joe\D_drive', linking to 📂D:
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$junction = "", [string]$targetDir = "")

try {
	if ($junction -eq "" ) { $symlink = Read-Host "Enter path and filename of the new junction" }
	if ($targetDir -eq "" ) { $target = Read-Host "Enter the path to the target directory" }

	New-Item -path "$symlink" -itemType Junction -value "$targetDir"
	if ($lastExitCode -ne 0) { throw "Command 'New-Item' has failed" }

	"✅ Created a new junction '$symlink', linking to 📂$targetDir"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
