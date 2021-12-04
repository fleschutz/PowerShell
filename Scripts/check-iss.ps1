<#
.SYNOPSIS
	Checks the ISS 
.DESCRIPTION
	This script checks the International Space Station (ISS) and report the position by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-iss
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz · License: CC0
#>

try {
	$ISS = (Invoke-WebRequest "http://api.open-notify.org/iss-now.json" -userAgent "curl" -useBasicParsing).Content | ConvertFrom-Json

	$Reply = "ISS is at $($ISS.iss_position.longitude)° longitude, $($ISS.iss_position.latitude)° latitude."
	"✔️ $Reply"
	& "$PSScriptRoot/speak-english.ps1" "$Reply"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
