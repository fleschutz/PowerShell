#!/snap/bin/powershell

# Syntax:       ./mute-audio.ps1
# Description:	mutes the audio
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

try {
	$obj = new-object -com wscript.shell
	$obj.SendKeys([char]173)
	write-output "OK"
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
