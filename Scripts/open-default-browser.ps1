<#
.SYNOPSIS
	Opens the default browser
.DESCRIPTION
	This script launches the default Web browser, optional with a given URL.
.PARAMETER URL
	Specifies the URL
.EXAMPLE
	PS> ./open-default-browser
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
