<#
.SYNOPSIS
	close-netflix.ps1 
.DESCRIPTION
	Closes the Netflix program gracefully
.EXAMPLE
	PS> ./close-netflix
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/close-program.ps1" "Netflix" "ApplicationFrameHost" "RuntimeBroker"
exit 0
