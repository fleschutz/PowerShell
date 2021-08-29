<#
.SYNOPSIS
	list-drives.ps1
.DESCRIPTION
	Lists all drives connected to the computer.
.EXAMPLE
	PS> .\list-drives.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	get-PSDrive -PSProvider FileSystem
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
