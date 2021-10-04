<#
.SYNOPSIS
	Closes Microsoft's Edge Web browser
.DESCRIPTION
	close-edge.ps1 
.EXAMPLE
	PS> ./close-edge
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/close-program.ps1" "Microsoft Edge" "msedge" "msedge"
exit 0 # success
