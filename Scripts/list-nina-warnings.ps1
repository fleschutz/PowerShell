<#
.SYNOPSIS
	Lists the current NINA warnings
.DESCRIPTION
	This PowerShell script queries the current NINA warnings and prints it.
.EXAMPLE
	PS> ./list-nina-warnings.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	Write-Progress "Loading NINA warnings..."
	$warnings = (Invoke-WebRequest -URI https://warnung.bund.de/api31/dwd/mapData.json -userAgent "curl" -useBasicParsing).Content | ConvertFrom-Json
	Write-Progress -completed "Done."
	Write-Output "Weather Warnings by DWD"
	Write-Output "-----------------------"
	foreach($warning in $warnings) {
		$startDate = $warning.startDate
		$expiresDate = $warning.expiresDate
		$severity = $warning.severity
		$urgency = $warning.urgency
		$type = $warning.type
		$message = $warning.i18nTitle.en
		Write-Output "* $type from $startDate to $($expiresDate): $message ($severity, $urgency)"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
