<#
.SYNOPSIS
	Closes Microsoft's Cortana application
.DESCRIPTION
	This script closes Microsoft's Cortana application gracefully.
.EXAMPLE
	PS> ./close-cortana
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/close-program.ps1" "Cortana" "Cortana" "Cortana"
exit 0 # success
