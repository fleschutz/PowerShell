<#
.SYNOPSIS
	Lists the current NINA warnings
.DESCRIPTION
	This PowerShell script queries the current NINA warnings and lists it.
.PARAMETER ARS
	Specifies the official regional key in Germany ("Amtlicher Regionalschlüssel", e.g. 09777, none by default)
.EXAMPLE
	PS> ./list-nina-warnings.ps1

	⚠️ Official SEVERE WEATHER WARNING of SEVERE THUNDERSTORMS with VERY HEAVY RAIN and HAIL
	   🕘 2024-06-26T07:53:00+02:00 ... 2024-06-26T08:45:00+02:00 (by DWD, Update, Severe, Immediate)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$ARS = "")

function ListWarningsOf([string]$source, [string]$URL)
{
	Write-Progress "Loading NINA - $source warnings..."
	$warnings = (Invoke-WebRequest -URI $URL -userAgent "curl" -useBasicParsing).Content | ConvertFrom-Json
	Write-Progress -completed "Done."

	foreach($warning in $warnings) {
		$title = $warning.i18nTitle.en
		if ("$title" -eq "") { $title = $warning.i18nTitle.de }
		$startDate = $warning.startDate
		$expiresDate = $warning.expiresDate
		$severity = $warning.severity
		$urgency = $warning.urgency
		$type = $warning.type
		Write-Output ""
		Write-Output "⚠️ $title"
		if ("$type" -ne "") {
			Write-Output "   🕘 $($startDate)...$expiresDate (by $source, $type, $severity, $urgency)"
		}
	}
}

try {
	if ("$ARS" -ne "") {
		ListWarningsOf "Region" "https://warnung.bund.de/api31/dashboard/$($ARS)0000000.json"
	} else {
		ListWarningsOf "Katwarn" "https://warnung.bund.de/api31/katwarn/mapData.json"
		ListWarningsOf "DWD"     "https://warnung.bund.de/api31/dwd/mapData.json"
		ListWarningsOf "Police"  "https://warnung.bund.de/api31/police/mapData.json"
		ListWarningsOf "LHP"     "https://warnung.bund.de/api31/lhp/mapData.json"
		ListWarningsOf "Biwapp"  "https://warnung.bund.de/api31/biwapp/mapData.json"
	} 	
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
