<#
.SYNOPSIS
	Halts the computer (needs admin rights)
.DESCRIPTION
	This script halts the local computer immediately (needs admin rights).
.EXAMPLE
	PS> ./poweroff
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#Requires -RunAsAdministrator

try {
	if ($IsLinux) {
		sudo shutdown
	} else {
		Stop-Computer
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
