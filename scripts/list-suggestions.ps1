<#
.SYNOPSIS
	Lists suggestions
.DESCRIPTION
	This PowerShell script lists "Did you mean?" suggestions from Google.
.EXAMPLE
	PS> ./list-suggestions.ps1 Joe
	joe biden
	joe cocker
	...
.PARAMETER text
	Specifies the word or sentence to get suggestions for.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$text = "")

try {
	if ("$text" -eq "") { $text = read-host "Enter a word or sentence to get suggestions for" }
	$URI = [uri]::escapeuristring("suggestqueries.google.com/complete/search?client=firefox&q=$text")
	$Content = (Invoke-WebRequest -URI $URI -useBasicParsing).Content 
	($Content | ConvertFrom-Json).SyncRoot | Select-Object -Skip 1
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
