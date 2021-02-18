#!/bin/powershell
<#
.SYNTAX         ./list-empty-dirs.ps1 [<dir-tree>]
.DESCRIPTION	lists empty subfolders within the given directory tree
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param($DirTree = "")

if ($DirTree -eq "" ) {
	$DirTree = read-host "Enter the path to the directory tree"
}

try {
	write-progress "Listing empty directories in $DirTree..."
	[int]$Count = 0
	Get-ChildItem $DirTree -recurse | Where {$_.PSIsContainer -eq $true} | Where {$_.GetFileSystemInfos().Count -eq 0} | ForEach-Object {
		write-output $_.FullName
		$Count++
	}
	write-host -foregroundColor green "Done - found $Count empty directories" 
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
