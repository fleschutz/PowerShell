<#
.SYNOPSIS
	Opens the WhatsApp website
.DESCRIPTION
	This script launches the Web browser with the WhatsApp website.
.EXAMPLE
	PS> ./open-whats-app-website
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://www.whatsapp.com/"
exit 0 # success
