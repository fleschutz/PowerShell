<#
.SYNOPSIS
	Opens Google Contacts
.DESCRIPTION
	This script launches the Web browser with Google Contacts website.
.EXAMPLE
	PS> ./open-google-contacts
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	& "$PSScriptRoot/open-browser.ps1" "https://contacts.google.com"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
