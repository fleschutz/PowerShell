<#
.SYNOPSIS
	reboot.ps1
.DESCRIPTION
	Reboots the local computer (needs admin rights)
.EXAMPLE
	PS> .\reboot.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

#Requires -RunAsAdministrator

try {
	Restart-Computer
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
