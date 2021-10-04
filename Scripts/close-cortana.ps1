<#
.SYNOPSIS
	Closes Microsoft's Cortana application
.DESCRIPTION
	close-cortana.ps1
.EXAMPLE
	PS> ./close-cortana
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/close-program.ps1" "Cortana" "Cortana" "Cortana"
exit 0 # success
