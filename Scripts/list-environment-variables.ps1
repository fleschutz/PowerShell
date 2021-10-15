<#
.SYNOPSIS
	Lists all environment variables
.DESCRIPTION
	This script lists all environment variables.
.EXAMPLE
	PS> ./list-environment-variables

	Name                           Value
	----                           -----
	ALLUSERSPROFILE                C:\ProgramData
	APPDATA                        C:\Users\Joe\AppData\Roaming
	...
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	Get-ChildItem env:
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
