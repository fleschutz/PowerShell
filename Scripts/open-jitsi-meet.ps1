<#
.SYNOPSIS
	Opens the Jitsi Meet website
.DESCRIPTION
	This script launches the Web browser with the Jitsi Meet website.
.EXAMPLE
	PS> ./open-jitsi-meet
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://meet.jit.si/"
exit 0 # success
