#!/snap/bin/powershell

# Syntax:       ./set-timer.ps1 [<seconds>]
# Description:	sets a timer for a countdown
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([int]$Seconds)
try {
	if ($Seconds -eq 0 ) {
		[int]$Seconds = read-host "Enter number of seconds"
	}
	for ($i = $Seconds; $i -gt 0; $i--) {
		write-progress "$i seconds"
		start-sleep -s 1
	}
	write-output "OK - $Seconds seconds countdown finished"
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
