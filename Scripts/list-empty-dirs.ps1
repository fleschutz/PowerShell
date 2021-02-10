#!/bin/powershell
<#
.SYNTAX         ./list-empty-dirs.ps1 [<dir-tree>]
.DESCRIPTION	lists empty subfolders within the given directory tree
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param($DirTree = "")

try {
	if ($DirTree -eq "" ) {
		$DirTree = read-host "Enter the path to the directory tree"
	}
	write-progress "Listing empty subfolders in $DirTree ..."
	(Get-ChildItem $DirTree -recurse | ? {$_.PSIsContainer -eq $True}) | ?{$_.GetFileSystemInfos().Count -eq 0} | select FullName
	echo "Done."
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
