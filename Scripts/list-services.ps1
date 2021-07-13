<#
.SYNOPSIS
	list-services.ps1 
.DESCRIPTION
	Lists the services on the local computer 
.EXAMPLE
	PS> .\list-services.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	Get-Service
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
