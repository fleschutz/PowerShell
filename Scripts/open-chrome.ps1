<#
.SYNOPSIS
	Launches the Chrome browser
.DESCRIPTION
	This PowerShell script launches the Google Chrome Web browser.
.EXAMPLE
	PS> ./open-chrome
.PARAMETER URL
	Specifies an optional URL
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$URL = "http://www.fleschutz.de")

try {
	start-process chrome.exe "$URL"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
