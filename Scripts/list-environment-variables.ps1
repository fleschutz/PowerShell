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
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
