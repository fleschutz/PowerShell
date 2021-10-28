<#
.SYNOPSIS
	Opens Google News
.DESCRIPTION
	This script launches the Web browser with the Google News website.
.EXAMPLE
	PS> ./open-google-news
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	& "$PSScriptRoot/open-browser.ps1" "https://news.google.com"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
