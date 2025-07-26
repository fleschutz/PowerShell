<#
.SYNOPSIS
	Writes a value with unit and range
.DESCRIPTION
	This PowerShell script writes the given value with the unit and the value range to the console.
.PARAMETER value
	Specifies the value
.EXAMPLE
	PS> ./write-value.ps1 95.0 "°C" 0 10 90 100
	[0--------95°C-100]
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([float]$value = 0.5, [string]$unit = "Mach", [float]$redMin, [float]$yellowMin, [float]$yellowMax, [float]$redMax)

function WriteValueInRange([float]$value, [string]$unit, [float]$redMin, [float]$yellowMin, [float]$yellowMax, [float]$redMax) {
	$line = "--------------------------------------"
	$text = "[$redMin$value$unit$redMax]"
	[float]$both = 20.0 - $text.Length
	if ($value -gt $redMax) {
		Write-Host "[$redMin$($line.Substring(0,$both))$redMax]" -noNewline
		Write-Host "$value$unit" -noNewline -foregroundColor red
	} elseif ($value -lt $redMin) {
		Write-Host "$value$unit" -noNewline -foregroundColor red
		Write-Host "[$redMin$($line.Substring(0,$both))$redMax] " -noNewline
	} else {
		[float]$left = (($value - $redMin) * $both) / ($redMax - $redMin)
		if ($left -lt 1.0) { $left = 1.0 }
		elseif ($left -gt ($both - 1.0)) { $left = $both - 1.0 }
		[float]$right = $both - $left
		Write-Host "[$redMin$($line.Substring(0,$left))" -noNewline
		if (($value -le $yellowMin) -or ($value -ge $yellowMax)) {
			Write-Host "$value$unit" -noNewline -foregroundColor yellow
		} else {
			Write-Host "$value$unit" -noNewline -foregroundColor green
		}
		Write-Host "$($line.Substring(0,$right))$redMax]" -noNewline
	}
}

Write-Host ""
Write-Host "   TRACK " -noNewline
WriteValueInRange 50.0 "°" 0 0 360 360
Write-Host ""

Write-Host "   ALT   " -noNewline
WriteValueInRange 800 "m" 0 0 6000 8000
Write-Host ""

Write-Host "   SPEED " -noNewline
WriteValueInRange 230 "km/h" 0 0 180 200
Write-Host ""

Write-Host "   BANK  " -noNewline
WriteValueInRange -30.3 "°" -30 -10 10 30
Write-Host ""

Write-Host "   ENG   " -noNewline
WriteValueInRange 2000 "RPM" 0 0 5000 6000
Write-Host ""

Write-Host "   TEMP  " -noNewline
WriteValueInRange 21.8 "°C" 0 10 90 100
Write-Host ""

Write-Host "   FUEL  " -noNewline
WriteValueInRange 0.1 "l" 0 5 60 65
Write-Host ""

Write-Host "   FREQ  " -noNewline
WriteValueInRange 104.4 "MHz" 80 80 108 108
Write-Host ""

Write-Host "   BRAKE " -noNewline
WriteValueInRange 0.0 "%" 0 -1 90 100
Write-Host ""

exit 0 # success
