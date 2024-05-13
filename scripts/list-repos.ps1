<#
.SYNOPSIS
	Lists Git repositories
.DESCRIPTION
	This PowerShell script lists all Git repositories in a folder with details such as latest tag/branch/status/URL.
.PARAMETER parentDir
	Specifies the path to the parent directory (current working directory by default)
.EXAMPLE
	PS> ./list-repos.ps1 C:\Repos
	
	Local Repo   Latest Tag   Branch    Status    Remote Repo
	----------   ----------   ------    ------    -----------
	📂cmake      v3.23.0      main      ✔️clean   ↓0 git@github.com:Kitware/CMake
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
		New-Object PSObject -property @{'Local Repo'="📂$folderName";'Latest Tag'="$latestTag";'Branch'="$branch";'Status'="$status";'Remote Repo'="↓$numCommits $remoteURL"}
	}
}

try {
	if (-not(Test-Path "$parentDir" -pathType container)) { throw "Can't access directory: $parentDir" }

	$null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	ListRepos | Format-Table -property @{e='Local Repo';width=19},@{e='Latest Tag';width=16},@{e='Branch';width=19},@{e='Status';width=10},'Remote Repo'
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
