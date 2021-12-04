<#
.SYNOPSIS
	Shows the Apple manuals
.DESCRIPTION
	This script launches the Web browser with the Apple online manual.
.EXAMPLE
	PS> ./show-apple-manual
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://support.apple.com/manuals"
exit 0 # success
