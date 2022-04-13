<#
.SYNOPSIS
	Turn audio off
.DESCRIPTION
	This PowerShell script mutes the default audio device immediately.
.EXAMPLE
	PS> ./turn-volume-off
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$obj = new-object -com wscript.shell
	$obj.SendKeys([char]173)
	& "$PSScriptRoot/give-reply.ps1" "Audio is off."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
