<#
.SYNTAX       list-files.ps1 [<dir-tree>]
.DESCRIPTION  lists all files in the given directory tree
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($DirTree = "")
if ($DirTree -eq "" ) { $DirTree = read-host "Enter path to directory tree" }

try {
	Get-ChildItem -path $DirTree -recurse | select FullName
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
