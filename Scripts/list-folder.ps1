<#
.SYNOPSIS
	Lists the folder content 
.DESCRIPTION
	This PowerShell script lists the directory content formatted in columns.
.PARAMETER SearchPattern
	Specifies the search pattern, "*" by default (means anything) 
.EXAMPLE
	PS> ./list-folder C:\
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$SearchPattern = "*")

function ListFolder { param([string]$SearchPattern)
	$Items = get-childItem -path "$SearchPattern"
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
	ListFolder $SearchPattern | format-wide -autoSize
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
