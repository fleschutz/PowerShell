<#
.SYNOPSIS
	Turns the volume off
.DESCRIPTION
	This script mutes the default audio device immediately.
.EXAMPLE
	PS> ./shut-up
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
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
