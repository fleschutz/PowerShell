<#
.SYNOPSIS
	open-browser.ps1 [<URL>]
.DESCRIPTION
	Opens the default Web browser, optional with given URL
.EXAMPLE
	PS> ./open-browser
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$URL = "http://www.fleschutz.de")

try {
	Start-Process $URL
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
