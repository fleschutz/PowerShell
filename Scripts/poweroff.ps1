<#
.SYNOPSIS
	poweroff.ps1
.DESCRIPTION
	Halts the local computer (needs admin rights).
.EXAMPLE
	PS> .\poweroff.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

#Requires -RunAsAdministrator

try {
	Stop-Computer
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
