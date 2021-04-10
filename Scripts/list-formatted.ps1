#!/usr/bin/pwsh
<#
.SYNTAX       list-formatted.ps1 [<directory>]
.DESCRIPTION  lists the current working directory formatted in columns
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($Directory = "$PWD")

function ListDir { param([string]$Path)
	$Items = get-childItem -path $Path
	foreach ($Item in $Items) {
		if ($Item.Name[0] -eq '.') { continue } # hidden file/dir
		if ($Item.Mode -like "d*") {
                    	New-Object PSObject -Property @{ Name = "$($Item.Name)/" }
		} else {
                    	New-Object PSObject -Property @{ Name = "$($Item.Name)" }
		}
	}
}

try {
	ListDir $Directory | format-wide -autoSize
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
