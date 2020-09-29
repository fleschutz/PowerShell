#!/snap/bin/powershell
#
# Syntax:	./speak.ps1
# Description:	speaks the given text
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

$Text = "Hello World!"
$voice = New-Object ComObject SAPI.SPVoice
$voice.Speak($Text);
exit 0
