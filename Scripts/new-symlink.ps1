<#
.SYNOPSIS
	Creates a new symbolic link file
.DESCRIPTION
	This PowerShell script creates a new symbolic link file.
.PARAMETER symlink
	Specifies the new symlink filename
.PARAMETER target
	Specifies the path to target
.EXAMPLE
	PS> ./new-symlink C:\Temp\HDD C:\
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$symlink = "", $[string]target = "")

try {
	if ($symlink -eq "" ) { $symlink = read-host "Enter new symlink filename" }
	if ($target -eq "" ) { $target = read-host "Enter path to target" }

	new-item -path "$symlink" -itemType SymbolicLink -Value "$target"

	"✔️ created new symlink $symlink ⭢ $target"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
