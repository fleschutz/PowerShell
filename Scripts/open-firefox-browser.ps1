<#
.SYNOPSIS
	Launches the Firefox browser
.DESCRIPTION
	This script launches the Mozilla Firefox Web browser.
.EXAMPLE
	PS> ./open-firefox-browser
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
		start-process firefox.exe "$URL"
	} else {
		start-process firefox.exe
	}
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
