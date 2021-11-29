<#
.SYNOPSIS
	Closes the Netflix app
.DESCRIPTION
	This script closes the Netflix application gracefully.
.EXAMPLE
	PS> ./close-netflix
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/close-program.ps1" "Netflix" "ApplicationFrameHost" "RuntimeBroker"
exit 0 # success
