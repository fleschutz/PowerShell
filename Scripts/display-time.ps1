<#
.SYNOPSIS
	display-time.ps1 [<seconds>]
.DESCRIPTION
	Displays the current time (for 10 seconds by default)
.EXAMPLE
	PS> ./display-time
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
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
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
