#!/snap/bin/powershell

# Syntax:       ./open-browser.ps1 [<URL>]
# Description:	starts the default Web browser, optional with given URL
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([string]$URL)
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
