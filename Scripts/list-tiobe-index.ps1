<#
.SYNOPSIS
	Lists the TIOBE index of top programming languages
.DESCRIPTION
	This PowerShell script lists the TIOBE index of top programming languages.
.EXAMPLE
	PS> ./list-tiobe-index
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

function WriteBar { param([string]$Text, [float]$Value, [float]$Max, [float]$Change)
	$Num = ($Value * 100.0) / $Max
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
	write-host -noNewLine " $Text $($Value)%"
	if ($Change -ge 0.0) {
		write-host -foregroundColor green " +$($Change)%"
	} else {
		write-host -foregroundColor red " $($Change)%"
	}
}

try {
	& write-big.ps1 "TIOBE INDEX 2021-06"
	"                                           Source: https://www.tiobe.com"
	""

	$Table = import-csv "$PSScriptRoot/../Data/TIOBE-index.csv"
	foreach($Row in $Table) {
		[string]$Name = $Row.Language
		[float]$Value = $Row.Popularity
		[float]$Change = $Row.Change
		WriteBar $Name $Value 14.0 $Change
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
