#!/snap/bin/powershell
<#
.SYNTAX         ./list-formatted.ps1 [<directory>]
.DESCRIPTION	lists the current working directory formatted in columns
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param([string]$Dir = "")

function ListDirectory { param([string]$Path)
	$Items = get-childItem -path $Path
	foreach ($Item in $Items) {
		if ($Item.Mode -eq "d-----") {
			#write-output "$($Item.name)/"
                    	New-Object PSObject -Property @{ Filename = "$($Item.Name)/" }
		} else {
			#write-output "$($Item.name)"
                    	New-Object PSObject -Property @{ Filename = "$($Item.Name)" }
		}
	}
}

try {
	if ($Dir -eq "") {
		$Dir = "$PWD"
	}
	ListDirectory $Dir | format-wide -autoSize
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
