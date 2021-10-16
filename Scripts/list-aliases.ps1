<#
.SYNOPSIS
	Lists all PowerShell aliases
.DESCRIPTION
	This scripts lists all PowerShell aliases.
.EXAMPLE
	PS> ./list-aliases

	CommandType     Name                                               Version    Source
	-----------     ----                                               -------    ------
	Alias           CFS -> ConvertFrom-String                          3.1.0.0    Microsoft.PowerShell.Utility
	Alias           fhx -> Format-Hex                                  3.1.0.0    Microsoft.PowerShell.Utility
	...
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	get-alias
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
