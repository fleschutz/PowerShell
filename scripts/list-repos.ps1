<#
.SYNOPSIS
	Lists Git repos
.DESCRIPTION
	This PowerShell script lists details of all Git repositories in a folder.
.PARAMETER parentDir
	Specifies the path to the parent directory (current working directory by default)
.EXAMPLE
	PS> ./list-repos C:\MyRepos
	
	Repository   Latest Tag   Branch    Status    Remote URL
	----------   ----------   ------    ------    ----------
	📂cmake      v3.23.0      main      ✔️clean    git@github.com:Kitware/CMake ↓0
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
		elseif ("$status" -like " M *") { $status = "⚠️modified" }
		New-Object PSObject -property @{'Repository'="📂$folderName";'Latest Tag'="$latestTag";'Branch'="$branch";'Status'="$status";'Remote URL'="$remoteURL ↓$numCommits";}
	}
}

try {
	if (-not(Test-Path "$parentDir" -pathType container)) { throw "Can't access directory: $parentDir" }

	$null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	ListRepos | Format-Table -property @{e='Repository';width=19},@{e='Latest Tag';width=18},@{e='Branch';width=20},@{e='Status';width=10},'Remote URL'
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
