<#
.SYNOPSIS
	Opens Google Contacts
.DESCRIPTION
	This script launches the Web browser with the Google Contacts website.
.EXAMPLE
	PS> ./open-google-contacts
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://contacts.google.com"
exit 0 # success
