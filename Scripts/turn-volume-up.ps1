<#
.SYNOPSIS
	Turns the volume up 
.DESCRIPTION
	This PowerShell script turns the audio volume up (+10% by default).
.PARAMETER percent
	Specifies the percent number
.EXAMPLE
	PS> ./turn-volume-up
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([int]$percent = 10)

try {
	$obj = New-Object -com wscript.shell
	for ([int]$i = 0; $i -lt $percent; $i += 2) {
		$obj.SendKeys([char]175) # each tick is +2%
	}
	& "$PSScriptRoot/give-reply.ps1" "$($percent)% louder."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
