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

param([float]$value = 0.5, [string]$unit = "Mach", [float]$min = 0.0, [float]$max = 10.0)

function WriteLine([float]$count) {
	while ($count -ge 1.0) {
		Write-Host "⎯" -noNewline
		$count -= 1.0
	}
	return $count
}

function WriteBlock([float]$value, [string]$unit, [float]$min, [float]$max) {
	$text = "[$min $($value)$unit $max]"
	[float]$left = 20.0 - $text.Length
	if ($value -gt $max) {
		Write-Host "[$min" -noNewline
		$rest = WriteLine $left
		Write-Host "$max]" -noNewline
		Write-Host " $($value)$unit " -noNewline -foregroundColor red
	} elseif ($value -lt $min) {
		Write-Host "$($value)$unit" -noNewline -foregroundColor red
		Write-Host " [$min" -noNewline
		$rest = WriteLine $left
		Write-Host "$max] " -noNewline
	} else {
		[float]$percent = (($value - $min) * $left) / ($max - $min)
		Write-Host "[$min" -noNewline
		$rest = WriteLine $percent
		Write-Host "$($value)$unit" -noNewline -foregroundColor green
		$rest = WriteLine ($left - $percent + $rest + 1.0)
		Write-Host "$max] " -noNewline
	}
}

WriteBlock -3.5 "°C" 0 100
Write-Host "CPU too cold"

WriteBlock 15 "°C" 0 100
Write-Host "OK"

WriteBlock 50 "°C" 0 100
Write-Host "OK"

WriteBlock 70 "°C" 0 100
Write-Host "OK"

WriteBlock 110 "°C" 0 100
Write-Host "CPU too hot "

exit 0 # success
