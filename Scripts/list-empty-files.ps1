<#
.SYNTAX       list-empty-files.ps1 [<dir-tree>]
.DESCRIPTION  lists empty files within the given directory tree
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($DirTree = "")

if ($DirTree -eq "" ) {
	$DirTree = read-host "Enter the path to the directory tree"
}

try {
	[int]$Count = 0
	write-progress "Listing empty files in $DirTree ..."
	get-childItem $DirTree -attributes !Directory -recurse | where {$_.Length -eq 0} | foreach-object {
		write-output $_.FullName
		$Count++
	}
	write-host -foregroundColor green "OK - found $Count empty file(s)" 
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
