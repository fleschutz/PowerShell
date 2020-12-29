#!/snap/bin/powershell
<#
.SYNTAX         ./list-empty-dirs.ps1 <dirtree> 
.DESCRIPTION	lists empty subfolders in the <directory tree> 
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

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
