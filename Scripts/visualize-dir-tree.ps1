#!/snap/bin/powershell
<#
.SYNTAX         ./visualize-dir-tree.ps1 [<dir-tree>]
.DESCRIPTION	visualizes the given/current directory tree
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param([string]$DirTree = "")

function VisualizeDirectory { param([string]$Directory, [int]$Depth)
	$Depth++
	$Items = get-childItem -path $Directory
	foreach ($Item in $Items) {
		$Filename = $Item.Name
		if ($Item.Mode -eq "d----") {
			for ($i = 0; $i -lt $Depth; $i++) {
				write-host -nonewline "+--"
			}
			write-host "$Filename/"
			VisualizeDirectory "$Directory\$Filename" $Depth
		} else {
			for ($i = 1; $i -lt $Depth; $i++) {
				write-host -nonewline "|  "
			}
			write-host "|-$Filename"
		}
	}
}

try {
	if ($DirTree -eq "") {
		$DirTree = "$PWD"
	}
	VisualizeDirectory $DirTree 0
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
