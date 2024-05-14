<#
.SYNOPSIS
	Lists the current weather warnings by NINA
.DESCRIPTION
	This PowerShell script queries the current NINA weather warnings and lists it.
.EXAMPLE
	PS> ./list-nina-warnings.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

function ListWarningsOf([string]$category, [string]$source)
{
	Write-Progress "Loading NINA warnings..."
	$warnings = (Invoke-WebRequest -URI https://warnung.bund.de/api31/$category/mapData.json -userAgent "curl" -useBasicParsing).Content | ConvertFrom-Json
	Write-Progress -completed "Done."

	foreach($warning in $warnings) {
		$message = $warning.i18nTitle.en
		$startDate = $warning.startDate
		$expiresDate = $warning.expiresDate
		$severity = $warning.severity
		$urgency = $warning.urgency
		$type = $warning.type
		Write-Output "* $message"
		Write-Output "  from $startDate to $expiresDate ($source $type, $severity, $urgency)"
		Write-Output ""
	}
}

try {
	Write-Output ""
	ListWarningsOf "katwarn" "Katwarn"
	ListWarningsOf "dwd"     "DWD"
	ListWarningsOf "police"  "Police"
	ListWarningsOf "lhp"     "LHP"
	ListWarningsOf "biwapp"  "Biwapp"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
