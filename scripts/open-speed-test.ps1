<#
.SYNOPSIS
	Opens Cloudflare's Speed Test
.DESCRIPTION
	This script launches the Web browser with Cloudflare's speed test website.
.EXAMPLE
	PS> ./open-speed-test.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

& "$PSScriptRoot/open-default-browser.ps1" "https://speed.cloudflare.com"
exit 0 # success
