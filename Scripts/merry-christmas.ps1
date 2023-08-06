<#
.SYNOPSIS
	Replies to "Merry Christmas"
.DESCRIPTION
	This PowerShell script replies to 'Merry Christmas' by text-to-speech (TTS).
.EXAMPLE
	PS> ./merry-christmas.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

$Reply = "Merry Christmas to you too!", "Happy Christmas to you too!" | Get-Random

& "$PSScriptRoot/speak-english.ps1" "$Reply"
exit 0 # success
