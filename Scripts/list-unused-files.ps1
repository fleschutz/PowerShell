<#
.SYNOPSIS
	list-unused-files.ps1 <dir-tree> <days>
.DESCRIPTION
	Lists files in the <directory tree> with last access time older than <days>
.EXAMPLE
	PS> ./list-unused-files C:\ 90
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$DirTree = "", [int]$NumberOfDaysUnused = 99)

write-host "Listing files in $DirTree with last access time older than $NumberOfDaysUnused days"

try {
	$cutOffDate = (Get-Date).AddDays(-$NumberOfDaysUnused)

	Get-ChildItem -path $DirTree -recurse | Where-Object {$_.LastAccessTime -le $cutOffDate} | select fullname

	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
