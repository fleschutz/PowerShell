<#
.SYNOPSIS
	Turns the volume off
.DESCRIPTION
	This PowerShell script mutes the default audio device immediately.
.EXAMPLE
	PS> ./turn-volume-off
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	$obj = new-object -com wscript.shell
	$obj.SendKeys([char]173)
	& "$PSScriptRoot/give-reply.ps1" "Audio is off."
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
