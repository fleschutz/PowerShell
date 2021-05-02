<#
.SYNTAX       create-symlink.ps1 [<symlink>] [<target>]
.DESCRIPTION  creates a symbolic link
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($Symlink = "", $Target = "")
if ($Symlink -eq "" ) { $Symlink = read-host "Enter filename of symlink" }
if ($Target -eq "" ) { $Target = read-host "Enter path to target" }

try {
	new-item -path "$Symlink" -itemType SymbolicLink -Value "$Target"

	write-host -foregroundColor green "✔️ symlink $Symlink created (pointing to $Target)"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
