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
	$files = Get-Item $filePattern
	$list = Select-String -path $filePattern -pattern "$textPattern" 
	foreach($item in $list) { New-Object PSObject -Property @{ 'FILE'="$($item.Path)"; 'LINE'="$($item.LineNumber):$($item.Line)" }	}
	"✅ Found $($list.Count) lines in $($files.Count) files containing '$textPattern'."
}

try {
	if ($textPattern -eq "" ) { $textPattern = Read-Host "Enter the text pattern (e.g. ALIEN)" }
	if ($filePattern -eq "" ) { $filePattern = Read-Host "Enter the file pattern (e.g. *.txt)" }

	ListLocations $textPattern $filePattern | Format-Table -property FILE,LINE -autoSize
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
