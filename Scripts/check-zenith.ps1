<#
.SYNOPSIS
	Checks the time of zenith 
.DESCRIPTION
	This script queries the time of zenith and answers by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-zenith
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$Reply = (Invoke-WebRequest http://wttr.in/?format="Zenith is at %z." -UserAgent "curl" -useBasicParsing).Content
	& "$PSScriptRoot/give-reply.ps1" "$Reply"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
