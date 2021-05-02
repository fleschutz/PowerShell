<#
.SYNTAX       list-empty-dirs.ps1 [<dir-tree>]
.DESCRIPTION  lists empty subfolders within the given directory tree
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($DirTree = "$PWD")

try {
	$DirTree = resolve-path "$DirTree/"
	write-progress "Listing empty directories in $DirTree..."
	[int]$Count = 0
	Get-ChildItem "$DirTree" -attributes Directory -recurse | Where {$_.GetFileSystemInfos().Count -eq 0} | ForEach-Object {
		"📂 $($_.FullName)"
		$Count++
	}
	"✔️ directory tree $DirTree has $Count empty directories" 
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
