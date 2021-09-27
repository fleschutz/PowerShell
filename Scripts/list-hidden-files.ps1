<#
.SYNOPSIS
	list-hidden-files.ps1 [<dir-tree>]
.DESCRIPTION
	Lists hidden files within the given directory tree
.EXAMPLE
	PS> ./list-hidden-files C:\
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$DirTree = "$PWD")

try {
	$DirTree = resolve-path "$DirTree"
	write-progress "Listing hidden files in $DirTree ..."

	[int]$Count = 0
	get-childItem "$DirTree" -attributes Hidden -recurse | foreach-object {
		"📄 $($_.FullName)"
		$Count++
	}
	"✔️ directory tree $DirTree has $Count hidden file(s)" 
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
