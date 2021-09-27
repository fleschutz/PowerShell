<#
.SYNOPSIS
	list-services.ps1 
.DESCRIPTION
	Lists the local computer services
.EXAMPLE
	PS> ./list-services
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	Get-Service
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
