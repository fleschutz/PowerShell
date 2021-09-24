<#
.SYNOPSIS
	list-cmdlets.ps1 
.DESCRIPTION
	Lists all PowerShell cmdlets
.EXAMPLE
	PS> ./list-cmdlets
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	Get-Command -Command-Type cmdlet
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
