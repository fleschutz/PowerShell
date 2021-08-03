<#
.SYNOPSIS
	mute-audio.ps1
.DESCRIPTION
	Mutes the audio output
.EXAMPLE
	PS> .\mute-audio.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

try {
	$obj = new-object -com wscript.shell
	$obj.SendKeys([char]173)
	"🔇 audio is muted"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
