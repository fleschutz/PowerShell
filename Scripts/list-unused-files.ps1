<#
.SYNOPSIS
	Lists unused files in a folder (including subfolders)
.DESCRIPTION
	Lists files in a folder with last access time older than <Days>
	list-unused-files.ps1 <DirTree> <Days>
	<DirTree> is the path to the directory tree
	<Days> is the number of days
.EXAMPLE
	PS> ./list-unused-files C:\ 100
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$DirTree = "", [int]$Days = 100)

write-host "Listing files in $DirTree with last access time older than $Days days"

try {
	$cutOffDate = (Get-Date).AddDays(-$Days)

	Get-ChildItem -path $DirTree -recurse | Where-Object {$_.LastAccessTime -le $cutOffDate} | select fullname

	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
