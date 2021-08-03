<#
.SYNOPSIS
	close-edge.ps1 
.DESCRIPTION
	Closes the Web browser Microsoft Edge gracefully
.EXAMPLE
	PS> .\close-edge.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

& "$PSScriptRoot/close-program.ps1" "Microsoft Edge" "msedge" "msedge"
exit 0
