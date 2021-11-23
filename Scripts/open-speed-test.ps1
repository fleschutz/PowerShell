<#
.SYNOPSIS
	Opens Cloudflare's Speed Test
.DESCRIPTION
	This script launches the Web browser with Cloudflare's speed test website.
.EXAMPLE
	PS> ./open-speed-test
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://speed.cloudflare.com"
exit 0 # success
