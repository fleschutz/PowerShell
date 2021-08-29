<#
.SYNOPSIS
	remove-empty-dirs.ps1 [<dir-tree>]
.DESCRIPTION
	Removes all empty subfolders within the given directory tree.
.EXAMPLE
	PS> .\remove-empty-dirs.ps1 C:\Temp
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$DirTree = "")

try {
	if ($DirTree -eq "" ) { $DirTree = read-host "Enter the path to the directory tree" }

	$Folders = @()
	foreach ($Folder in (Get-ChildItem -path  "$DirTree" -Recurse | Where { $_.PSisContainer })) {
		$Folders += New-Object PSObject -Property @{
			Object = $Folder
			Depth = ($Folder.FullName.Split("\")).Count
		}
	}
	$Folders = $Folders | Sort Depth -Descending

	$Deleted = @()
	foreach ($Folder in $Folders)
	{
		if ($Folder.Object.GetFileSystemInfos().Count -eq 0) {
			$Deleted += New-Object PSObject -Property @{
				Folder = $Folder.Object.FullName
				Deleted = (Get-Date -Format "hh:mm:ss tt")
				Created = $Folder.Object.CreationTime
				'Last Modified' = $Folder.Object.LastWriteTime
				Owner = (Get-Acl $Folder.Object.FullName).Owner
			}
			Remove-Item -Path $Folder.Object.FullName -Force
		}
	}
	"✔️  Done."
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
