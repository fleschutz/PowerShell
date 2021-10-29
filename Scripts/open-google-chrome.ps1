<#
.SYNOPSIS
	Launches the Google Chrome Web browser
.DESCRIPTION
	This script launches the Google Chrome Web browser.
.EXAMPLE
	PS> ./open-google-chrome
.PARAMETER URL
	Specifies an optional URL
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$URL = "")

try {
	if ("$URL" -ne "") {
		start-process chrome.exe "$URL"
	} else {
		start-process chrome.exe
	}
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
