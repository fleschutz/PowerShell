<#
.SYNOPSIS
	Closes the Microsoft Edge Web browser
.DESCRIPTION
	This script closes the Microsoft Edge Web browser gracefully.
.EXAMPLE
	PS> ./close-microsoft-edge
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/close-program.ps1" "Microsoft Edge" "msedge" "msedge"
exit 0 # success
