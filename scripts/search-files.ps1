<#
.SYNOPSIS
	Searches for text in files
.DESCRIPTION
	This PowerShell script searches for the given text pattern in the given files.
.PARAMETER textPattern
	Specifies the text pattern to search for
.PARAMETER filePattern
	Specifies the files to search 
.EXAMPLE
	PS> ./search-files.ps1 UFO *.ps1

	FILE                                              LINE
	----                                              ----
	/home/Markus/PowerShell/scripts/check-month.ps1   17: $MonthName = (Get-Date -UFormat %B)
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$textPattern = "", [string]$filePattern = "")

function ListLocations { param([string]$textPattern, [string]$filePattern)
	$list = Select-String -path $filePattern -pattern "$textPattern" 
	foreach($item in $list) { New-Object PSObject -Property @{ 'FILE'="$($item.Path)"; 'LINE'="$($item.LineNumber):$($item.Line)" }	}
	"✅ Found $($list.Count) lines containing '$textPattern' in $filePattern."
}

try {
	if ($textPattern -eq "" ) { $textPattern = Read-Host "Enter the text pattern, e.g. 'UFO'" }
	if ($filePattern -eq "" ) { $filePattern = Read-Host "Enter the file pattern, e.g. '*.ps1'" }

	ListLocations $textPattern $filePattern | Format-Table -property FILE,LINE -autoSize
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
