<#
.SYNOPSIS
	Opens Google Contacts
.DESCRIPTION
	This PowerShell script launches the Web browser with the Google Contacts website.
.EXAMPLE
	PS> ./open-google-contacts
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

& "$PSScriptRoot/open-default-browser.ps1" "https://contacts.google.com"
exit 0 # success
