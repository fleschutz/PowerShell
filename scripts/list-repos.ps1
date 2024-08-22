<#
.SYNOPSIS
	Lists Git repositories
.DESCRIPTION
	This PowerShell script lists all Git repositories under a folder with details such as latest tag, branch, remote URL, and status.
.PARAMETER parentDir
	Specifies the path to the parent directory (current working directory by default)
.EXAMPLE
	PS> ./list-repos.ps1 C:\MyRepos
	
	REPOSITORY   LATEST TAG   BRANCH    REMOTE URL                        STATUS
	----------   ----------   ------    ----------                        ------
	📂cmake      v3.30.2      master    https://github.com/Kitware/CMake  ✔️clean ↓0
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$parentDir = "$PWD")

function ListRepos { 
	$folders = (Get-ChildItem "$parentDir" -attributes Directory)
	foreach($folder in $folders) {
		$folderName = (Get-Item "$folder").Name
		$latestTagCommitID = (git -C "$folder" rev-list --tags --max-count=1)
		if ($latestTagCommitID -ne "") {
	        	$latestTag = (git -C "$folder" describe --tags $latestTagCommitID)
		} else {
			$latestTag = ""
		}
		$branch = (git -C "$folder" branch --show-current)
		$remoteURL = (git -C "$folder" remote get-url origin)
		$numCommits = (git -C "$folder" rev-list HEAD...origin/$branch --count)
		$status = (git -C "$folder" status --short)
		if ("$status" -eq "") { $status = "✔️clean" }
		elseif ("$status" -like " M *") { $status = "⚠️changed" }
		New-Object PSObject -property @{'REPOSITORY'="📂$folderName";'LATEST TAG'="$latestTag";'BRANCH'="$branch";'REMOTE URL'="$remoteURL";'STATUS'="$status ↓$numCommits"}
	}
}

try {
	if (-not(Test-Path "$parentDir" -pathType container)) { throw "Can't access parent directory at: $parentDir" }

	$null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	ListRepos | Format-Table -property @{e='REPOSITORY';width=19},@{e='LATEST TAG';width=16},@{e='BRANCH';width=19},@{e='REMOTE URL';width=47},@{e='STATUS';width=12}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
