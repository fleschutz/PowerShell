<#
.SYNOPSIS
	Turns the volume on
.DESCRIPTION
	This script unmutes the audio output.
.EXAMPLE
	PS> .\turn-volume-on.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$obj = new-object -com wscript.shell
	$obj.SendKeys([char]173)
	& "$PSScriptRoot/give-reply.ps1" "Audio is on."
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
