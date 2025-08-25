<#
.SYNOPSIS
	Lists Git repositories
.DESCRIPTION
	This PowerShell script lists all Git repositories under a folder with details such as latest tag, branch, remote URL, and status.
.PARAMETER parentDir
	Specifies the path to the parent directory (current working directory by default)
.EXAMPLE
	PS> ./list-repos.ps1 C:\MyRepos
	
	REPOSITORY   LATEST TAG   BRANCH    REMOTE URL                             STATUS
	----------   ----------   ------    ----------                             ------
	📂cmake      v3.30.2      master    https://github.com/Kitware/CMake ↓0    ✅clean 
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$parentDir = "$PWD")

function ListRepos { 
	$dirs = (Get-ChildItem "$parentDir" -attributes Directory)
	foreach($dir in $dirs) {
		$dirName = (Get-Item "$dir").Name
		$latestTagCommitID = (git -C "$dir" rev-list --tags --max-count=1)
		if ("$latestTagCommitID" -ne "") {
	        	$latestTag = (git -C "$dir" describe --tags $latestTagCommitID)
		} else {
			$latestTag = ""
		}
		$branch = (git -C "$dir" branch --show-current)
		$remoteURL = (git -C "$dir" remote get-url origin)
		$numCommits = (git -C "$dir" rev-list HEAD...origin/$branch --count)
		$status = (git -C "$dir" status --short)
		if ("$status" -eq "") { $status = "✅clean" }
		elseif ("$status" -like " M *") { $status = "⚠️changed" }
		New-Object PSObject -property @{'REPOSITORY'="📂$dirName";'LATEST TAG'="$latestTag";'BRANCH'="$branch";'REMOTE URL'="$remoteURL ↓$numCommits";'STATUS'="$status"}
	}
}

try {
	if (-not(Test-Path "$parentDir" -pathType container)) { throw "Can't access parent directory at: $parentDir" }

	$null = (git --version)
	if ($lastExitCode -ne 0) { throw "Can't execute 'git' - make sure Git is installed and available" }

	ListRepos | Format-Table -property @{e='REPOSITORY';width=19},@{e='LATEST TAG';width=16},@{e='BRANCH';width=19},@{e='REMOTE URL';width=50},@{e='STATUS';width=10}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
