<#
.SYNTAX       search-files.ps1 [<pattern>] [<path>]
.DESCRIPTION  searches the given pattern in the given files
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($Pattern = "", $Path = "")
if ($Pattern -eq "" ) { $Pattern = read-host "Enter search pattern" }
if ($Path -eq "" ) { $Path = read-host "Enter path to files" }

function ListScripts { param([string]$Pattern, [string]$Path)
	$List = Select-String -Path $Path -Pattern "$Pattern" 
	foreach ($Item in $List) {
		New-Object PSObject -Property @{
			'Path' = "$($Item.Path)"
			'Line' = "$($Item.LineNumber)"
			'Text' = "$($Item.Line)"
		}
	}
	write-output "(pattern found at $($List.Count) locations)"
}

try {
	ListScripts $Pattern $Path | format-table -property Path,Line,Text
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
