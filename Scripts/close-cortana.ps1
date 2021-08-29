<#
.SYNOPSIS
	close-cortana.ps1 
.DESCRIPTION
	Closes Cortana gracefully.
.EXAMPLE
	PS> .\close-cortana.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/close-program.ps1" "Cortana" "Cortana" "Cortana"
exit 0
