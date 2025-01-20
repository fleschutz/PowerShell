<#
.SYNOPSIS
	Create a junction
.DESCRIPTION
	This PowerShell script creates a new junction, linking to a target.
.PARAMETER junction
	Specifies the file path to the new junction
.PARAMETER target
	Specifies the file path to the target
.EXAMPLE
	PS> ./new-junction.ps1 D:\Win10 C:\Windows
	✅ Created new junction 'D:\Windows' linking to: C:\Windows
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$junction = "", [string]$target = "")

try {
	if ($junction -eq "" ) { $symlink = Read-Host "Enter new junction filename" }
	if ($target -eq "" ) { $target = Read-Host "Enter path to target" }

	New-Item -path "$symlink" -itemType Junction -value "$target"
	if ($lastExitCode -ne "0") { throw "Command 'New-Item' has failed" }

	"✅ Created new junction '$symlink' linking to: $target"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
