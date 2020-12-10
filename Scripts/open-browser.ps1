#!/snap/bin/powershell

# Syntax:       ./open-browser.ps1 [<URL>]
# Description:	starts the default Web browser, optional with given URL
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([string]$URL)
if ($URL -eq "" ) {
	$URL = "http://www.fleschutz.de"
}


try {
	Start-Process $URL
	exit 0
} catch {
	Write-Error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
