<#
.SYNTAX       list-tiobe-index.ps1 
.DESCRIPTION  lists the TIOBE index of top programming languages
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

function WriteBar { param([string]$Text, [float]$Value, [float]$Max, [string]$Hint)
	$Num = ($Value * 70.0) / $Max
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
	"  $Text  $($Value)%  ($Hint)"
}

try {
	& write-big.ps1 "TIOBE INDEX 2021-06"
	""

	$Table = import-csv "$PSScriptRoot/../Data/TIOBE-index.csv"
	foreach($Row in $Table) {
		[string]$Name = $Row.Language
		[float]$Value = $Row.Popularity
		[string]$Hint = $Row.Change
		WriteBar $Name $Value 14.0 $Hint
	}
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
