<#
.SYNOPSIS
	Lists the local computer services
.DESCRIPTION
	This script lists all local computer services.
.EXAMPLE
	PS> ./list-services

	Status   Name               DisplayName
	------   ----               -----------
	Running  AarSvc_886c2       Agent Activation Runtime_886c2
	Running  Apple Mobile De... Apple Mobile Device Service
	...
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
