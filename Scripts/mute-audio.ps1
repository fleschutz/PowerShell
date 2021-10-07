<#
.SYNOPSIS
	Mutes the audio output
.DESCRIPTION
	This script mutes the default audio device immediately.
.EXAMPLE
	PS> ./mute-audio
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$obj = new-object -com wscript.shell
	$obj.SendKeys([char]173)
	"🔇 audio is muted"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
