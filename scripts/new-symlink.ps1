<#
.SYNOPSIS
	Creates a new symlink
.DESCRIPTION
	This PowerShell script creates a new symbolic link file, linking to a target.
.PARAMETER symlink
	Specifies the file path to the new symlink file
.PARAMETER target
	Specifies the file path to the target
.EXAMPLE
	PS> ./new-symlink.ps1 C:\User\Markus\Windows C:\Windows
	✅ Created new symlink 'C:\User\Markus\Windows' linking to: C:\Windows
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$symlink = "", [string]$target = "")

try {
	if ($symlink -eq "" ) { $symlink = Read-Host "Enter new symlink filename" }
	if ($target -eq "" ) { $target = Read-Host "Enter path to target" }

	New-Item -path "$symlink" -itemType SymbolicLink -value "$target"
	if ($lastExitCode -ne 0) { throw "Command 'New-Item' has failed" }

	"✅ Created new symlink '$symlink' linking to: $target"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
