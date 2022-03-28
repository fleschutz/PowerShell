<#
.SYNOPSIS
	Lists Git repositories
.DESCRIPTION
	This PowerShell script lists the details of all Git repositories in a folder.
.PARAMETER ParentDir
	Specifies the path to the parent folder.
.EXAMPLE
	PS> ./list-repos C:\MyRepos
	
	No  Repository   Branch    Status
	--  ----------   ------    ------
	1   cmake        main      clean
	2   opencv       main      modified
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$ParentDir = "$PWD")

function ListRepos { param([string]$ParentDir)
	[int]$No = 0
	$Folders = (get-childItem "$ParentDir" -attributes Directory)
	foreach ($Folder in $Folders) {
		$No++
		$Repository = (get-item "$Folder").Name
		$Branch = (git -C "$Folder" branch --show-current)
		$Status = (git -C "$Folder" status --short)
		if ("$Status" -eq "") { $Status = "clean" }
		if ("$Status" -like " M *") { $Status = "modified" }

		New-Object PSObject -property @{ 'No'="$No"; 'Repository'="$Repository"; 'Branch'="$Branch"; 'Status'="$Status"; }
	}
}

try {
	if (-not(test-path "$ParentDir" -pathType container)) { throw "Can't access directory: $ParentDir" }

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	ListRepos | format-table -property @{e='No';width=3},@{e='Repository';width=25},@{e='Branch';width=20},Status
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}