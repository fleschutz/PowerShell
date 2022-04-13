<#
.SYNOPSIS
	Checks the ISS position
.DESCRIPTION
	This PowerShell script queries the position of the International Space Station (ISS) and replies by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-iss-position
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	$ISS = (Invoke-WebRequest "http://api.open-notify.org/iss-now.json" -userAgent "curl" -useBasicParsing).Content | ConvertFrom-Json

	& "$PSScriptRoot/give-reply.ps1" "The International Space Station is currently at $($ISS.iss_position.longitude)° longitude and $($ISS.iss_position.latitude)° latitude."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
