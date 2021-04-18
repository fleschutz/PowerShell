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
		$Name = $Item.Name
		if ($Name[0] -eq '.') { continue } # hidden file/dir
		if ($Item.Mode -like "d*") { $Icon = "📂" 
		} elseif ($Name -like "*.iso") { $Icon = "📀"
		} elseif ($Name -like "*.mp3") { $Icon = "🎵"
		} elseif ($Name -like "*.epub") { $Icon = "📓"
		} else { $Icon = "📄" }
		new-object PSObject -Property @{ Name = "$Icon$Name" }
	}
}

try {
	ListDir $Directory | format-wide -autoSize
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
