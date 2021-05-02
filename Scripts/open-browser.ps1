<#
.SYNTAX       open-browser.ps1 [<URL>]
.DESCRIPTION  starts the default Web browser, optional with given URL
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($URL = "http://www.fleschutz.de")

try {
	Start-Process $URL
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
