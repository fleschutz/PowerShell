<#
.SYNOPSIS
	open-browser.ps1 [<URL>]
.DESCRIPTION
	Opens the default Web browser, optional with given URL
.EXAMPLE
	PS> .\open-browser.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param($URL = "http://www.fleschutz.de")

try {
	Start-Process $URL
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
