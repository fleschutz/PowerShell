<#
.SYNOPSIS
	Lists empty subfolders within a directory tree
.DESCRIPTION
	This PowerShell script scans and lists all empty subfolders within the given directory tree.
.PARAMETER DirTree
	Specifies the path to the directory tree
.EXAMPLE
	PS> ./list-empty-dirs C:\
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
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
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
