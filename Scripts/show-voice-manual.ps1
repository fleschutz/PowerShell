<#
.SYNOPSIS
	Shows the voice control manual
.DESCRIPTION
	This script launches the Web browser with the voice control manual.
.EXAMPLE
	PS> ./show-voice-manual
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://github.com/fleschutz/PowerShell/blob/master/Docs/VoiceControl.md"
exit 0 # success
