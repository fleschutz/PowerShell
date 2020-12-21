#!/snap/bin/powershell

# Syntax:       ./list-files.ps1 [<folder>]
# Description:	lists all files in the given <folder> and also in every subfolder
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([string]$Folder)

try {
	if ($Folder -eq "" ) {
		[String]$Folder = read-host "Enter path to folder"
	}
	Get-ChildItem -path $Folder -recurse | select FullName
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
