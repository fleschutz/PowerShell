<#
.SYNOPSIS
	Reboots the local computer (needs admin rights)
.DESCRIPTION
	This PowerShell script reboots the local computer (needs admin rights).
.EXAMPLE
	PS> ./reboot
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

#Requires -RunAsAdministrator

try {
	Restart-Computer
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
