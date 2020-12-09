#!/snap/bin/powershell

# Syntax:       ./list-unused-files.ps1 <dirtree> <days>
# Description:	lists files in the <directory tree> with last access time older than <days>
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([string]$DirTree, [int]$NumberOfDaysUnused)

write-host "Listing files in $DirTree with last access time older than $NumberOfDaysUnused days"

try {
	$cutOffDate = (Get-Date).AddDays(-$NumberOfDaysUnused)

	Get-ChildItem -path $DirTree -recurse | Where-Object {$_.LastAccessTime -le $cutOffDate} | select fullname

	exit 0
} catch {
	Write-Error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
