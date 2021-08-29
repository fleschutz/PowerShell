<#
.SYNOPSIS
	unmute-audio.ps1
.DESCRIPTION
	Unmutes the audio output.
.EXAMPLE
	PS> .\unmute-audio.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$obj = new-object -com wscript.shell
	$obj.SendKeys([char]173)
	"🔈 audio is unmuted"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
