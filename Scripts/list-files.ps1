<#
.SYNOPSIS
	list-files.ps1 [<dir-tree>]
.DESCRIPTION
	Lists all files in the given directory tree.
.EXAMPLE
	PS> .\list-files.ps1 C:\
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$DirTree = "")

try {
	if ($DirTree -eq "" ) { $DirTree = read-host "Enter path to directory tree" }

	Get-ChildItem -path $DirTree -recurse | select FullName
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
