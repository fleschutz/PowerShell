<#
.SYNOPSIS
	Lists all environment variables
.DESCRIPTION
	This PowerShell script lists all environment variables.
.EXAMPLE
	PS> ./list-environment-variables

	Name                           Value
	----                           -----
	ALLUSERSPROFILE                C:\ProgramData
	APPDATA                        C:\Users\Joe\AppData\Roaming
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	Get-ChildItem env:
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
