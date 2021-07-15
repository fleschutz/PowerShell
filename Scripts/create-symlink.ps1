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
	Author: Markus Fleschutz / License: CC0
#>

param([string]$Symlink = "", $[string]Target = "")

try {
	if ($Symlink -eq "" ) { $Symlink = read-host "Enter filename of symlink" }
	if ($Target -eq "" ) { $Target = read-host "Enter path to target" }

	new-item -path "$Symlink" -itemType SymbolicLink -Value "$Target"

	"✔️ created symlink $Symlink (pointing to $Target)"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
