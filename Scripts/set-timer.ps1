<#
.SYNTAX       set-timer.ps1 [<seconds>]
.DESCRIPTION  sets a timer for a countdown
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param([int]$Seconds = 0)
if ($Seconds -eq 0 ) { [int]$Seconds = read-host "Enter number of seconds" }

try {
	for ($i = $Seconds; $i -gt 0; $i--) {
		clear-host
		./write-big "T-$i seconds"
		start-sleep -s 1
	}
	write-host -foregroundColor green "Done - $Seconds seconds countdown finished"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
