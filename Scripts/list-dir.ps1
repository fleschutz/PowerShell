<#
.SYNTAX       list-dir.ps1 [<pattern>]
.DESCRIPTION  lists the directory content formatted in columns
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($Pattern = "*")

function ListDir { param([string]$Pattern)
	$Items = get-childItem -path "$Pattern"
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
	ListDir $Pattern | format-wide -autoSize
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
