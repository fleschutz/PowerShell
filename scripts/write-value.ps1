<#
.SYNOPSIS
	Writes a value with value range
.DESCRIPTION
	This PowerShell script writes the given value with value range to the console.
.PARAMETER value
	Specifies the value
.EXAMPLE
	PS> ./write-value.ps1 0.5 Mach 0 10
	[0⎯0.5 Mach⎯⎯⎯⎯⎯⎯⎯⎯⎯10]
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([float]$value = 0.5, [string]$unit = "Mach", [float]$redMin = 0.0, [float]$redMax = 10.0)

function WriteLine([float]$count) {
	while ($count -ge 1.0) {
		Write-Host "⎯" -noNewline
		$count -= 1.0
	}
	return $count
}

function WriteBlock([float]$value, [string]$unit, [float]$redMin, [float]$yellowMin, [float]$yellowMax, [float]$redMax) {
	$text = "[$redMin $($value)$unit $redMax]"
	[float]$left = 20.0 - $text.Length
	if ($value -gt $redMax) {
		Write-Host "[$redMin" -noNewline
		$rest = WriteLine $left
		Write-Host "$redMax]" -noNewline
		Write-Host " $($value)$unit " -noNewline -foregroundColor red
	} elseif ($value -lt $redMin) {
		Write-Host "$($value)$unit" -noNewline -foregroundColor red
		Write-Host " [$redMin" -noNewline
		$rest = WriteLine $left
		Write-Host "$redMax] " -noNewline
	} elseif (($value -le $yellowMin) -or ($value -ge $yellowMax)) {
		[float]$percent = (($value - $redMin) * $left) / ($redMax - $redMin)
		Write-Host "[$redMin" -noNewline
		$rest = WriteLine $percent
		Write-Host "$($value)$unit" -noNewline -foregroundColor yellow
		$rest = WriteLine ($left - $percent + $rest + 1.0)
		Write-Host "$redMax] " -noNewline
	} else {
		[float]$percent = (($value - $redMin) * $left) / ($redMax - $redMin)
		Write-Host "[$redMin" -noNewline
		$rest = WriteLine $percent
		Write-Host "$($value)$unit" -noNewline -foregroundColor green
		$rest = WriteLine ($left - $percent + $rest + 1.0)
		Write-Host "$redMax] " -noNewline
	}
}

WriteBlock -3.5 "°C" 0 10 90 100
Write-Host "CPU too cold"

WriteBlock 5 "°C" 0 10 90 100
Write-Host "CPU quite cold"

WriteBlock 15 "°C" 0 10 90 100
Write-Host "OK"

WriteBlock 50 "°C" 0 10 90 100
Write-Host "OK"

WriteBlock 70 "°C" 0 10 90 100
Write-Host "OK"

WriteBlock 95 "°C" 0 10 90 100
Write-Host "CPU quite hot "

WriteBlock 110 "°C" 0 10 90 100
Write-Host "CPU too hot "

exit 0 # success
