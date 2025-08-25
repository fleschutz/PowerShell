<#
.SYNOPSIS
	Lists the installed hotfixes
.DESCRIPTION
	This PowerShell script lists the installed hotfixes.
.EXAMPLE
	PS> ./list-installed-hotfixes.ps1

	Source        Description      HotFixID      InstalledBy          InstalledOn
	------        -----------      --------      -----------          -----------
	MyPC          Update           KB5054977     NT AUTHORITY\SYSTEM  4/10/2025 12:00:00 AM
.NOTES
	https://github.com/fleschutz/PowerShell
.LINK
	Author: Markus Fleschutz | License: CC0
#>

try {
	Get-Hotfix
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
