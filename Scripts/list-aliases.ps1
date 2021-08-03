<#
.SYNOPSIS
	list-aliases.ps1
.DESCRIPTION
	Lists all PowerShell aliases 
.EXAMPLE
	PS> .\list-aliases.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

try {
	get-alias
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
