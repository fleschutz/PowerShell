#!/snap/bin/powershell
#
# Syntax:	./speak.ps1 [<text>]
# Description:	speaks the given text
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([string]$Text)
if ($Text -eq "") {
	$Text = "Hello World!"
}

try {
	$voice = New-Object ComObject SAPI.SPVoice
	$voice.Speak($Text);
	exit 0
} catch { Write-Error $Error[0] }
exit 1
