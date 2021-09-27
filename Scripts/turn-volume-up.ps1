<#
.SYNOPSIS
	turn-volume-up.ps1 [<percent>]
.DESCRIPTION
	Turns the audio volume up (+10% by default)
.EXAMPLE
	PS> ./turn-volume-up
.NOTES
	Author:  Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([int]$percent = 10)

try {
	$obj = New-Object -com wscript.shell
	for ([int]$i = 0; $i -lt $percent; $i += 2) {
		$obj.SendKeys([char]175) # each tick is +2%
	}
	"🔊️ volume +$($percent)%"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
