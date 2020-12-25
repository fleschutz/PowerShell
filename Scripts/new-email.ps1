#!/snap/bin/powershell

# Syntax:       ./new-email.ps1 [<address>]
# Description:	starts the default email client to write a new email
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([string]$emailAddress)
try {
	if ($emailAddress -eq "" ) {
		$emailAddress = "markus@fleschutz.de"
	}
	$URL="mailto:$emailAddress"
	Start-Process $URL
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
