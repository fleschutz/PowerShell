<#
.SYNOPSIS
	Closes Microsoft's Edge Web browser
.DESCRIPTION
	This script closes Microsoft's Edge Web browser gracefully.
.EXAMPLE
	PS> ./close-edge
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/close-program.ps1" "Microsoft Edge" "msedge" "msedge"
exit 0 # success
