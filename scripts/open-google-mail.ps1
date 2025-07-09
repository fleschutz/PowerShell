<#
.SYNOPSIS
	Opens Google Mail
.DESCRIPTION
	This PowerShell script launches the Web browser with the Google Mail website.
.EXAMPLE
	PS> ./open-google-mail.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

& "$PSScriptRoot/open-default-browser.ps1" "https://mail.google.com"
exit 0 # success
