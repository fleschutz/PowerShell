<#
.SYNOPSIS
	Searches for a text pattern in files
.DESCRIPTION
	This PowerShell script searches for the given pattern in the given files.
.PARAMETER textPattern
	Specifies the text pattern to search for
.PARAMETER filePattern
	Specifies the files to search 
.EXAMPLE
	PS> ./search-files UFO C:\Temp\*.txt
	...
	✔️ Found 'UFO' at 9 locations.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$textPattern = "", [string]$filePattern = "")

function ListLocations { param([string]$Pattern, [string]$Path)
	$list = Select-String -path $Path -pattern "$Pattern" 
	foreach ($item in $list) {
		New-Object PSObject -Property @{ 'FILE'="$($item.Path)"; 'LINE'="$($item.LineNumber):$($item.Line)" }
	}
	Write-Output "✔️ Found '$Pattern' at $($list.Count) locations."
}

try {
	if ($textPattern -eq "" ) { $textPattern = Read-Host "Enter the text pattern (e.g. 'UFO')" }
	if ($filePattern -eq "" ) { $filePattern = Read-Host "Enter the file pattern (e.g. '*.txt')" }

	ListLocations $textPattern $filePattern | Format-Table -property FILE,LINE -autoSize
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
