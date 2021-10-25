<#
.SYNOPSIS
	Opens Facebook's website
.DESCRIPTION
	This script starts the Web browser and opens Facebook's website.
.EXAMPLE
	PS> ./open-facebook
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	& "$PSScriptRoot/open-browser.ps1" "https://www.facebook.com"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
