<#
.SYNOPSIS
	Closes the Netflix app
.DESCRIPTION
	This PowerShell script closes the Netflix application gracefully.
.EXAMPLE
	PS> ./close-netflix
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

& "$PSScriptRoot/close-program.ps1" "Netflix" "ApplicationFrameHost" "RuntimeBroker"
exit 0 # success
