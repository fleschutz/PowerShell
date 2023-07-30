<#
.SYNOPSIS
	Lists Git repos
.DESCRIPTION
	This PowerShell script lists details of all Git repositories in a folder.
.PARAMETER ParentDir
	Specifies the path to the parent directory.
.EXAMPLE
	PS> ./list-repos C:\MyRepos
	
	Repository    Branch    LatestTag    Status
	----------    ------    ---------    ------
	cmake         main      v3.23.0      clean
	opencv        main      4.5.5        modified
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$ParentDir = "$PWD")

function ListRepos { 
	$Folders = (Get-ChildItem "$ParentDir" -attributes Directory)
	foreach($Folder in $Folders) {
		$Repository = (Get-Item "$Folder").Name
		$Branch = (git -C "$Folder" branch --show-current)
		$LatestTagCommitID = (git -C "$Folder" rev-list --tags --max-count=1) | out-null
	        $LatestTag = (git -C "$Folder" describe --tags $LatestTagCommitID)
		$NumCommits = (git -C "$Folder" rev-list HEAD...origin/$Branch --count)
		$Status = (git -C "$Folder" status --short)
		if ("$Status" -eq "") { $Status = "clean" }
		elseif ("$Status" -like " M *") { $Status = "MODIFIED" }
		New-Object PSObject -property @{ 'Repository'="📂$Repository"; 'Branch'="$Branch"; 'Latest Tag'="$LatestTag"; 'Updates'="↓$NumCommits"; 'Status'="$Status"; }
	}
}

try {
	if (-not(Test-Path "$ParentDir" -pathType container)) { throw "Can't access directory: $ParentDir" }

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	ListRepos | Format-Table -property @{e='Repository';width=22},@{e='Branch';width=20},'Latest Tag',@{e='Updates';width=10},Status
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
