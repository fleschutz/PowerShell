<#
.SYNOPSIS
	Writes a chart
.DESCRIPTION
	This PowerShell script writes a chart.
.EXAMPLE
	PS> ./write-chart
.NOTES
	Author: Markus Fleschutz / License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

function WriteChartLine { param([string]$Text, [float]$Value, [float]$Max)
	$Num = ($Value * 40.0) / $Max
	while ($Num -ge 1.0) {
		write-host -noNewLine "█"
		$Num -= 1.0
	}
	if ($Num -ge 0.875) {
		write-host -noNewLine "▉"
	} elseif ($Num -ge 0.75) {
		write-host -noNewLine "▊"
	} elseif ($Num -ge 0.625) {
		write-host -noNewLine "▋"
	} elseif ($Num -ge 0.5) {
		write-host -noNewLine "▌"
	} elseif ($Num -ge 0.375) {
		write-host -noNewLine "▍"
	} elseif ($Num -ge 0.25) {
		write-host -noNewLine "▎"
	} elseif ($Num -ge 0.125) {
		write-host -noNewLine "▏"
	}
	if ($Max -eq 100.0) {
		write-host " $($Value)% $Text"
	} else {
		write-host " $Value / $Max $Text"
	}
}

"2021 Wins"
WriteChartLine "Markus" 40.5 100.0
WriteChartLine "Andrea" 30.9 100.0
exit 0 # success
