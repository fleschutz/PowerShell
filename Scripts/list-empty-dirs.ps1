#!/snap/bin/powershell
#
# Syntax:       ./list-empty-dirs.ps1 <dirtree> 
# Description:	lists empty subfolders in the <directory tree> 
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([string]$DirTree)

write-host "Listing empty subfolders in $DirTree ..."

try {
	(gci $DirTree -r | ? {$_.PSIsContainer -eq $True}) | ?{$_.GetFileSystemInfos().Count -eq 0} | select FullName
	echo "Done."
	exit 0
} catch { Write-Error $Error[0] }
exit 1
