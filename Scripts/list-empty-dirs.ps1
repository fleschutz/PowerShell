<#
.SYNOPSIS
	list-empty-dirs.ps1 [<dir-tree>]
.DESCRIPTION
	Lists empty subfolders within the given directory tree
.EXAMPLE
	PS> ./list-empty-dirs C:\
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$DirTree = "$PWD")

try {
	$DirTree = resolve-path "$DirTree/"
	write-progress "Listing empty directories in $DirTree..."
	[int]$Count = 0
	Get-ChildItem "$DirTree" -attributes Directory -recurse | Where {$_.GetFileSystemInfos().Count -eq 0} | ForEach-Object {
		"📂 $($_.FullName)"
		$Count++
	}
	"✔️ directory tree $DirTree has $Count empty directories" 
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
