<#
.SYNOPSIS
	Turn audio on
.DESCRIPTION
	This PowerShell script immediately unmutes the audio output.
.EXAMPLE
	PS> .\turn-volume-on
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$obj = new-object -com wscript.shell
	$obj.SendKeys([char]173)
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
