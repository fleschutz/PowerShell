#!/usr/bin/pwsh
<#
.SYNTAX       ./show-dir-tree.ps1 [<dir-tree>]
.DESCRIPTION  visualizes the given/current directory tree
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($DirTree = "")

function VisualizeDirectory { param([string]$Directory, [int]$Depth)
	$Depth++
	$Items = get-childItem -path $Directory
	foreach ($Item in $Items) {
		$Filename = $Item.Name
		if ($Item.Mode -like "d*") {
			for ($i = 0; $i -lt $Depth; $i++) {
				write-host -nonewline "+--"
			}
			write-host -foregroundColor green "$Filename/"
			VisualizeDirectory "$Directory\$Filename" $Depth
			$global:NumDirs++
		} else {
			for ($i = 1; $i -lt $Depth; $i++) {
				write-host -nonewline "|  "
			}
			write-host "|-$Filename ($($Item.Length) bytes)"
			$global:NumBytes += $Item.Length
		}
	}
}

try {
	if ($DirTree -eq "") {
		$DirTree = "$PWD"
	}
	$global:NumDirs = 1
	$global:NumBytes = 0
	VisualizeDirectory $DirTree 0
	write-host "($($global:NumDirs) dirs, $($global:NumBytes) bytes total)"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
