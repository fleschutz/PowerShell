<#
.SYNOPSIS
	create-symlink.ps1 [<symlink>] [<target>]
.DESCRIPTION
	Creates a symbolic link file
.EXAMPLE
	PS> .\create-symlink.ps1 C:\Temp\HDD C:\
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

param([string]$symlink = "", $[string]target = "")

try {
	if ($symlink -eq "" ) { $symlink = read-host "Enter new symlink filename" }
	if ($target -eq "" ) { $target = read-host "Enter path to target" }

	new-item -path "$symlink" -itemType SymbolicLink -Value "$target"

	"✔️ created symlink $symlink ⭢ $target"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
