<#
.SYNOPSIS
	Turns the volume fully up
.DESCRIPTION
	This PowerShell script turns the audio volume fully up to 100%.
.EXAMPLE
	PS> ./turn-volume-fully-up
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$obj = New-Object -com wscript.shell
	for ([int]$i = 0; $i -lt 100; $i += 2) {
		$obj.SendKeys([char]175) # each tick is +2%
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
