<#
.SYNOPSIS
	Lists all PowerShell aliases
.DESCRIPTION
	This PowerShell scripts lists all PowerShell aliases.
.EXAMPLE
	PS> ./list-aliases

	CommandType     Name                                               Version    Source
	-----------     ----                                               -------    ------
	Alias           CFS -> ConvertFrom-String                          3.1.0.0    Microsoft.PowerShell.Utility
	Alias           fhx -> Format-Hex                                  3.1.0.0    Microsoft.PowerShell.Utility
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	get-alias
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
