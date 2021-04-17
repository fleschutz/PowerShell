#!/usr/bin/pwsh
<#
.SYNTAX       list-hidden-files.ps1 [<dir-tree>]
.DESCRIPTION  lists hidden files within the given directory tree
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($DirTree = "$PWD")

try {
	$DirTree = resolve-path "$DirTree/"
	[int]$Count = 0
	write-progress "Listing hidden files in $DirTree ..."
	get-childItem "$DirTree" -attributes Hidden -recurse | foreach-object {
		"📄 $($_.FullName)"
		$Count++
	}
	"✔️ directory tree $DirTree has $Count hidden file(s)" 
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
