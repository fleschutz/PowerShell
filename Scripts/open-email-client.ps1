#!/snap/bin/powershell

# Syntax:       ./open-email-client.ps1
# Description:	starts the default email client 
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

try {
	Start-Process "mailto:markus@fleschutz.de"
	exit 0
} catch {
	Write-Error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
