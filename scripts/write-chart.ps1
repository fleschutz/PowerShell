<#
.SYNOPSIS
	Writes a chart
.DESCRIPTION
	This PowerShell script writes an horizontal chart to the console.
.EXAMPLE
	PS> ./write-chart.ps1
	
	BOWLING RESULTS 2024
	████████████████▏ 40.5% Joe
	████████████▎ 30.9% Tom
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

function WriteChartLine { param([string]$Text, [float]$Value, [float]$Max)
	$Num = ($Value * 40.0) / $Max
	while ($Num -ge 1.0) {
		Write-Host -noNewLine "█"
		$Num -= 1.0
	}
	if ($Num -ge 0.875) {
		Write-Host -noNewLine "▉"
	} elseif ($Num -ge 0.75) {
		Write-Host -noNewLine "▊"
	} elseif ($Num -ge 0.625) {
		Write-Host -noNewLine "▋"
	} elseif ($Num -ge 0.5) {
		Write-Host -noNewLine "▌"
	} elseif ($Num -ge 0.375) {
		Write-Host -noNewLine "▍"
	} elseif ($Num -ge 0.25) {
		Write-Host -noNewLine "▎"
	} elseif ($Num -ge 0.125) {
		Write-Host -noNewLine "▏"
	}
	if ($Max -eq 100.0) {
		Write-Host " $($Value)% $Text"
	} else {
		Write-Host " $Value / $Max $Text"
	}
}

Write-Host "`nBOWLING RESULTS 2024" -foregroundColor green
WriteChartLine "Joe" 40.5 100.0
WriteChartLine "Tom" 30.9 100.0
exit 0 # success
