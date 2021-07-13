<#
.SYNOPSIS
	list-environment-variables.ps1
.DESCRIPTION
	Lists all environment variables
.EXAMPLE
	PS> .\list-environment-variables.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	Get-ChildItem env:
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
