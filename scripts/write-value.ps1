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
	$line = "------------------------------------------------"
	$text = "[$redMin$($value)$unit $redMax]"
	[float]$total = 20.0 - $text.Length
	if ($value -gt $redMax) {
		Write-Host "[$redMin$($line.Substring(0, $total))$redMax]" -noNewline
		Write-Host "$($value)$unit " -noNewline -foregroundColor red
	} elseif ($value -lt $redMin) {
		Write-Host "$($value)$unit" -noNewline -foregroundColor red
		Write-Host "[$redMin$($line.Substring(0, $total))$redMax] " -noNewline
	} else {
		[float]$leftSide = (($value - $redMin) * $total) / ($redMax - $redMin)
		if ($leftSide -lt 1.0) { $leftSide = 1.0 }
		if ($leftSide -gt ($total - 1.0)) { $leftSide = $total - 1.0 }
		Write-Host "[$redMin$($line.Substring(0, $leftSide))" -noNewline
		if (($value -le $yellowMin) -or ($value -ge $yellowMax)) {
			Write-Host "$($value)$unit" -noNewline -foregroundColor yellow
		} else {
			Write-Host "$($value)$unit" -noNewline -foregroundColor green
		}
		Write-Host "$($line.Substring(0, $total - $leftSide + 0.49))$redMax] " -noNewline
	}
}

WriteValueInRange -3.5 "°C" 0 10 90 100
Write-Host "CPU too cold"

WriteValueInRange 5 "°C" 0 10 90 100
Write-Host "CPU quite cold"

WriteValueInRange 15 "°C" 0 10 90 100
Write-Host "OK"

WriteValueInRange 50 "°C" 0 10 90 100
Write-Host "OK"

WriteValueInRange 70 "°C" 0 10 90 100
Write-Host "OK"

WriteValueInRange 95 "°C" 0 10 90 100
Write-Host "CPU quite hot "

WriteValueInRange 110 "°C" 0 10 90 100
Write-Host "CPU too hot "

exit 0 # success
