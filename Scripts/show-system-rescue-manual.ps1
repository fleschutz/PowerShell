<#
.SYNOPSIS
	Shows the SystemRescue manual
.DESCRIPTION
	This script launches the Web browser with the SystemRescue online manual.
.EXAMPLE
	PS> ./show-system-rescue-manual
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.system-rescue.org/manual/"
exit 0 # success
