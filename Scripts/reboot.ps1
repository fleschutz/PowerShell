<#
.SYNOPSIS
	Reboots the local computer (needs admin rights)
.DESCRIPTION
	This script reboots the local computer (needs admin rights).
.EXAMPLE
	PS> ./reboot
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

#Requires -RunAsAdministrator

try {
	Restart-Computer
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
