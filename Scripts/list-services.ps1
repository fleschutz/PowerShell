<#
.SYNOPSIS
	Lists the local computer services
.DESCRIPTION
	This PowerShell script lists all local computer services.
.EXAMPLE
	PS> ./list-services

	Status   Name               DisplayName
	------   ----               -----------
	Running  AarSvc_886c2       Agent Activation Runtime_886c2
	Running  Apple Mobile De... Apple Mobile Device Service
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	Get-Service
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
