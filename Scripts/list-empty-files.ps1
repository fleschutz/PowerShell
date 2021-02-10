#!/bin/powershell
<#
.SYNTAX         ./list-empty-files.ps1 [<dir-tree>]
.DESCRIPTION	lists empty files within the given directory tree
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param($DirTree = "")

try {
	if ($DirTree -eq "" ) {
		$DirTree = read-host "Enter the path to the directory tree"
	}
	write-progress "Listing empty files in $DirTree ..."
	[int]$Count = 0
	Get-ChildItem $DirTree -recurse | Where {$_.PSIsContainer -eq $false} | Where {$_.Length -eq 0} | ForEach-Object {
		write-output $_.FullName
		$Count++
	}
	write-host -foregroundColor green "Done - found $Count empty files" 
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
