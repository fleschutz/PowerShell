<#
.SYNOPSIS
	Spells a word
.DESCRIPTION
	This script spells the given word by text-to-speech (TTS).
.EXAMPLE
	PS> ./spell-word
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

$Reply = "T E S T"

& "$PSScriptRoot/give-reply.ps1" "$Reply"
exit 0 # success
