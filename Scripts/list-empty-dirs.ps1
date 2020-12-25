#!/snap/bin/powershell

# Syntax:       ./list-empty-dirs.ps1 <dirtree> 
# Description:	lists empty subfolders in the <directory tree> 
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([string]$DirTree)

try {
	write-progress "Listing empty subfolders in $DirTree ..."
	(Get-ChildItem $DirTree -recurse | ? {$_.PSIsContainer -eq $True}) | ?{$_.GetFileSystemInfos().Count -eq 0} | select FullName
	echo "Done."
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
