<#
.SYNOPSIS
	close-edge.ps1 
.DESCRIPTION
	Closes the Microsoft Edge Web browser
.EXAMPLE
	PS> ./close-edge
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/close-program.ps1" "Microsoft Edge" "msedge" "msedge"
exit 0 # success
