<#
.SYNOPSIS
	Writes a value with value range
.DESCRIPTION
	This PowerShell script writes the given value to stdout.
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

function WriteLine([float]$count)
{
	for ([int]$i = 0; $i -lt $count; $i++) {
		Write-Host "⎯" -noNewline
	}
}

function WriteBlock([float]$value, [string]$unit, [float]$min, [float]$max) {
	$text = "[$min $value $unit $max]"
	$left = 32 - $text.Length
	if ($value -gt $max) {
		Write-Host "[$min" -noNewline
		WriteLine $left
		Write-Host "$max]" -noNewline
		Write-Host " $value $unit " -noNewline -foregroundColor red
	} elseif ($value -lt $min) {
		Write-Host "$value $unit" -noNewline -foregroundColor red
		Write-Host " [$min" -noNewline
		WriteLine $left
		Write-Host "$max] " -noNewline
	} else {
		[float]$percent = ($value * 100.0) / $max
		Write-Host "[$min" -noNewline
		WriteLine ($percent / 5.0)
		Write-Host "$value $unit" -noNewline -foregroundColor green
		WriteLine ((100.0 - $percent) / 5.0)
		Write-Host "$max] " -noNewline
	}
}

WriteBlock -11.5 "Mach" 0.0 10.0
Write-Host "Too slow"

WriteBlock 0.5 "Mach" 0.0 10.0
Write-Host "Good"

WriteBlock 5 "Mach" 0.0 10.0
Write-Host "Good"

WriteBlock 7 "Mach" 0.0 10.0
Write-Host "Good"

WriteBlock 15 "Mach" 0.0 10.0
Write-Host "Too fast"

exit 0 # success
