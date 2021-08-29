#Requires -RunAsAdministrator
<#
.SYNOPSIS
	reboot.ps1
.DESCRIPTION
	Reboots the local computer (needs admin rights).
.EXAMPLE
	PS> .\reboot.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	Restart-Computer
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
