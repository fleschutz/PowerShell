<#
.SYNOPSIS
	Lists old Git branches
.DESCRIPTION
	This PowerShell script only lists Git repository branches matching: (1) branch name pattern + (2) branch was already merged + (3) last commit pattern
.PARAMETER pathToRepo
	Specifies the path to the Git repository (current working directory by default)
.PARAMETER branchNamePattern
	Specifies the branch names
.PARAMETER lastCommitPattern
	Specifies the last commit dates
.EXAMPLE
	PS> ./list-old-branches.ps1 C:\Repos\ninja
q#>

param([string]$pathToRepo = "$PWD", [string]$branchNamePattern = "origin/dev/mf/*", [string]$lastCommitPattern = "2021-*")

try {
	Write-Host "(1/3) Searching for Git executable...    " -noNewline
        & git --version
        if ($lastExitCode -ne 0) { throw "Can't execute 'git' - make sure Git is installed and available" }

        "(2/4) Checking local repository..."
        if (!(Test-Path "$pathToRepo" -pathType container)) { throw "Can't access repo folder: $pathToRepo" }

	"(3/4) Querying branches matching: branch-name='$branchNamePattern' + already merged"
	$branches = $(git -C "$pathToRepo" branch --list --remotes --no-color --no-column --merged HEAD "$branchNamePattern")
	if ($lastExitCode -ne 0) { throw "'git branch --list' failed" }

	"(4/4) Listing branches matching: last-commit-date='$lastCommitPattern'"
	""
	"DATE OF LAST COMMIT  BRANCH NAME"
	"-------------------  -----------"
	foreach($branch in $branches) {
		$branchName = $branch.Trim() # remove leading spaces

		$dateOfLastCommit = (git -C "$pathToRepo" log -1 --format=%cs $branchName)
		if ($dateOfLastCommit -notlike $lastCommitPattern) { continue} # too young

		"$dateOfLastCommit           $branchName"
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
