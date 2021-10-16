<#
.SYNOPSIS
	Creates a new symbolic link file
.DESCRIPTION
	This script creates a new symbolic link file.
.PARAMETER symlink
	Specifies the new symlink filename
.PARAMETER target
	Specifies the path to target
.EXAMPLE
	PS> ./new-symlink C:\Temp\HDD C:\
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$symlink = "", $[string]target = "")

try {
	if ($symlink -eq "" ) { $symlink = read-host "Enter new symlink filename" }
	if ($target -eq "" ) { $target = read-host "Enter path to target" }

	new-item -path "$symlink" -itemType SymbolicLink -Value "$target"

	"✔️ created new symlink $symlink ⭢ $target"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
