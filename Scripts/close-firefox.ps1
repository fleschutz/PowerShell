<#
.SYNOPSIS
	close-firefox.ps1 
.DESCRIPTION
	Closes the Firefox Web browser gracefully
.EXAMPLE
	PS> .\close-firefox.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

& "$PSScriptRoot/close-program.ps1" "Mozilla Firefox" "firefox" "firefox"
exit 0
