<#
.SYNOPSIS
	Searches for a pattern in files
.DESCRIPTION
	This PowerShell script searches for a pattern in the given files.
.PARAMETER pattern
	Specifies the search pattern
.PARAMETER files
	Specifies the files
.EXAMPLE
	PS> ./search-files UFO C:\Temp\*.txt
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$pattern = "", [string]$files = "")

function ListLocations { param([string]$Pattern, [string]$Path)
	$List = Select-String -Path $Path -Pattern "$Pattern" 
	foreach ($Item in $List) {
		New-Object PSObject -Property @{
			'Path' = "$($Item.Path)"
			'Line' = "$($Item.LineNumber)"
			'Text' = "$($Item.Line)"
		}
	}
	write-output "(found $($List.Count) locations with pattern '$pattern')"
}

try {
	if ($pattern -eq "" ) { $pattern = read-host "Enter search pattern" }
	if ($files -eq "" ) { $files = read-host "Enter path to files" }

	ListLocations $pattern $files | format-table -property Path,Line,Text
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
