#!/snap/bin/powershell

# Syntax:       ./display-time.ps1 
# Description:	displays the current time
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

try {
	for ($i = 0; $i -lt 1000; $i++) {
		$CurrentTime = Get-Date -format "yyyy-MM-dd HH:mm:ss" 
		clear-host
		write-output ""
		./write-big $CurrentTime
		write-output ""
		start-sleep -s 1
	}
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
