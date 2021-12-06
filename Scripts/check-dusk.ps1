<#
.SYNOPSIS
	Checks the time of dusk 
.DESCRIPTION
	This script queries the time of dusk and answers by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-dusk
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$Reply = (Invoke-WebRequest http://wttr.in/?format="Dusk is at %d." -UserAgent "curl" -useBasicParsing).Content

	& "$PSScriptRoot/give-reply.ps1" "$Reply"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
