<#
.SYNOPSIS
	Creates a new symlink
.DESCRIPTION
	This PowerShell script creates a new symbolic link file, linking to a target.
.PARAMETER symlink
	Specifies the path to the new symlink file
.PARAMETER target
	Specifies the path to the target
.EXAMPLE
	PS> ./new-symlink.ps1 C:\User\Markus\Windows C:\Windows
	✅ New symlink file 'C:\User\Markus\Windows' created, linking to: C:\Windows
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

	"✅ New symlink file '$symlink' created, linking to: $target"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
