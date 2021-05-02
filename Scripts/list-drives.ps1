<#
.SYNTAX       list-drives.ps1
.DESCRIPTION  lists all drives connected to the computer
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

try {
	get-PSDrive -PSProvider FileSystem
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
