#!/bin/powershell
<#
.SYNTAX         ./open-browser.ps1 [<URL>]
.DESCRIPTION	starts the default Web browser, optional with given URL
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param([string]$URL = "")

try {
	if ($URL -eq "" ) {
		$URL = "http://www.fleschutz.de"
	}
	Start-Process $URL
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
