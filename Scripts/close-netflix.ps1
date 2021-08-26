<#
.SYNOPSIS
	close-netflix.ps1 
.DESCRIPTION
	Closes Netflix gracefully
.EXAMPLE
	PS> .\close-netflix.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

& "$PSScriptRoot/close-program.ps1" "Netflix" "ApplicationFrameHost" "RuntimeBroker"
exit 0
