<#
.SYNOPSIS
	Opens Google Mail
.DESCRIPTION
	This script launches the Web browser with the Google Mail website.
.EXAMPLE
	PS> ./open-google-mail
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://mail.google.com"
exit 0 # success
