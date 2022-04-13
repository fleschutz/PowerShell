<#
.SYNOPSIS
	Halts the local computer (needs admin rights)
.DESCRIPTION
	This script halts the local computer. It needs admin rights.
.EXAMPLE
	PS> ./poweroff
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

#Requires -RunAsAdministrator

try {
	Stop-Computer
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
