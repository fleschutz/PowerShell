<#
.SYNOPSIS
	Lists all PowerShell cmdlets
.DESCRIPTION
	This PowerShell script lists all PowerShell cmdlets.
.EXAMPLE
	PS> ./list-cmdlets

	CommandType     Name                                  Version    Source
	-----------     ----                                  -------    ------
	Function        Add-BCDataCacheExtension              1.0.0.0    BranchCache
	Function        Add-BitLockerKeyProtector             1.0.0.0    BitLocker
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	Get-Command -Command-Type cmdlet
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
