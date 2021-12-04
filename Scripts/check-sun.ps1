<#
.SYNOPSIS
	Checks the sun 
.DESCRIPTION
	This script determines Sun details and answers by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-sun
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$Reply = (Invoke-WebRequest http://wttr.in/?format="Dawn is at %D, sunrise at %S, zenith at %z, sunset at %s, dusk at %d" -UserAgent "curl" -useBasicParsing).Content
	"✔️ $Reply"
	& "$PSScriptRoot/speak-english.ps1" "$Reply"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
