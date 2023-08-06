<#
.SYNOPSIS
	Lists all installed PowerShell scripts 
.DESCRIPTION
	This PowerShell script lists all installed PowerShell scripts.
.EXAMPLE
	PS> ./list-installed-scripts.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

Get-InstalledScript
exit # success
