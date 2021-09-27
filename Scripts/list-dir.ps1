<#
.SYNOPSIS
	list-dir.ps1 [<pattern>]
.DESCRIPTION
	Lists the directory content formatted in columns
.EXAMPLE
	PS> ./list-dir C:\
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$Pattern = "*")

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
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
