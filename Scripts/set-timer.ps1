<#
.SYNOPSIS
	Sets a timer for a countdown
.DESCRIPTION
	This script sets a timer for a countdown.
.PARAMETER Seconds
	Specifies the number of seconds
.EXAMPLE
	PS> ./set-timer 60
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([int]$Seconds = 0)

try {
	if ($Seconds -eq 0 ) { [int]$Seconds = read-host "Enter number of seconds" }

	for ($i = $Seconds; $i -gt 0; $i--) {
		clear-host
		./write-big "T-$i seconds"
		start-sleep -s 1
	}

	"✔️ $Seconds seconds countdown finished"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
