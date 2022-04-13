<#
.SYNOPSIS
	Displays the current time
.DESCRIPTION
	This PowerShell script displays the current time (for 10 seconds by default)
.PARAMETER Seconds
	Specifies the number of seconds to display the time
.EXAMPLE
	PS> ./display-time
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([int]$Seconds = 10)

try {
	for ([int]$i = 0; $i -lt $Seconds; $i++) {
		clear-host
		write-output ""
		$CurrentTime = Get-Date -format "yyyy-MM-dd HH:mm:ss" 
		./write-big $CurrentTime
		write-output ""
		start-sleep -s 1
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
