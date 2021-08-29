<#
.SYNOPSIS
	list-environment-variables.ps1
.DESCRIPTION
	Lists all environment variables.
.EXAMPLE
	PS> .\list-environment-variables.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	Get-ChildItem env:
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
