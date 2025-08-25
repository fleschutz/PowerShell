<#
.SYNOPSIS
	Tells the time until New Year
.DESCRIPTION
	This PowerShell script calculates the time until New Year and replies by text-to-speech (TTS).
.EXAMPLE
	PS> ./tell-new-year.ps1
	(listen and enjoy)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$now = [DateTime]::Now
	$NewYear = [Datetime]("12/31/" + $now.Year)
	$days = ($NewYear – $now).Days + 1
	if ($days -gt 1) {
		& "$PSScriptRoot/speak-english.ps1" "New Year is in $days days."
	} elseif ($days -eq 1) {
		& "$PSScriptRoot/speak-english.ps1" "New Year is tomorrow."
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
