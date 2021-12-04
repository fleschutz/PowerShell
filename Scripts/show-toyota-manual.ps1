<#
.SYNOPSIS
	Shows the Toyota manuals
.DESCRIPTION
	This script launches the Web browser with the Toyota online manuals.
.EXAMPLE
	PS> ./show-toyota-manual
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.toyota.com/owners/resources/warranty-owners-manuals"
exit 0 # success
