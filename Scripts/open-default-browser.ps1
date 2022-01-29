<#
.SYNOPSIS
	Opens the default browser
.DESCRIPTION
	This PowerShell script launches the default Web browser, optional with a given URL.
.PARAMETER URL
	Specifies the URL
.EXAMPLE
	PS> ./open-default-browser
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$URL = "http://www.fleschutz.de")

try {
	Start-Process $URL
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
