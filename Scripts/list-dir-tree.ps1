<#
.SYNOPSIS
	list-dir-tree.ps1 [<dir-tree>]
.DESCRIPTION
	Lists the full directory tree
.EXAMPLE
	PS> ./list-dir-tree C:\
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$DirTree = "$PWD")

function ListDir { param([string]$Directory, [int]$Depth)
	$Depth++
	$Items = get-childItem -path $Directory
	foreach ($Item in $Items) {
		$Filename = $Item.Name
		if ($Item.Mode -like "d*") {
			for ($i = 0; $i -lt $Depth; $i++) {
				write-host -nonewline "+--"
			}
			write-host -foregroundColor green "📂$Filename"
			ListDir "$Directory\$Filename" $Depth
			$global:Dirs++
		} else {
			for ($i = 1; $i -lt $Depth; $i++) {
				write-host -nonewline "|  "
			}
			write-host "|-$Filename ($($Item.Length) bytes)"
			$global:Files++
			$global:Bytes += $Item.Length
		}
	}
}

try {
	[int]$global:Dirs = 1
	[int]$global:Files = 0
	[int]$global:Bytes = 0
	ListDir $DirTree 0
	write-host "($($global:Dirs) directories, $($global:Files) files, $($global:Bytes) bytes total)"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
