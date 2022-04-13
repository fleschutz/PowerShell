<#
.SYNOPSIS
	Lists Git repositories
.DESCRIPTION
	This PowerShell script lists the details of all Git repositories in a folder.
.PARAMETER ParentDir
	Specifies the path to the parent folder.
.EXAMPLE
	PS> ./list-repos C:\MyRepos
	
	No  Repository   Branch   LatestTag   Status
	--  ----------   ------   ---------   ------
	1   cmake        main     v3.23.0     clean
	2   opencv       main     4.5.5       modified
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$ParentDir = "$PWD")

function ListRepos { 
	[int]$No = 0
	$Folders = (Get-ChildItem "$ParentDir" -attributes Directory)
	foreach ($Folder in $Folders) {
		$No++
		$Repository = (get-item "$Folder").Name
		$Branch = (git -C "$Folder" branch --show-current)
		$LatestTagCommitID = (git -C "$Folder" rev-list --tags --max-count=1)
	        $LatestTag = (git -C "$Folder" describe --tags $LatestTagCommitID)
		$Status = (git -C "$Folder" status --short)
		if ("$Status" -eq "") { $Status = "clean" }
		if ("$Status" -like " M *") { $Status = "modified" }

		New-Object PSObject -property @{ 'No'="$No"; 'Repository'="$Repository"; 'Branch'="$Branch"; 'LatestTag'="$LatestTag"; 'Status'="$Status"; }
	}
}

try {
	if (-not(test-path "$ParentDir" -pathType container)) { throw "Can't access directory: $ParentDir" }

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	ListRepos | Format-Table -property @{e='No';width=3},@{e='Repository';width=25},@{e='Branch';width=20},LatestTag,Status
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
