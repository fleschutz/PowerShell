<#
.SYNOPSIS
	cherry-picker.ps1 [<CommitID>] [<CommitMessage>] [<Branches>] [<RepoDir>]
.DESCRIPTION
	Cherry-picks a Git commit into one or more branches (branch names need to be separated by spaces)
	NOTE: in case of merge conflicts the script stops immediately! 
.EXAMPLE
	PS> ./cherry-picker 93849f889 "Fix typo" "v1 v2 v3"
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$CommitID = "", [string]$CommitMessage = "", [string]$Branches = "", [string]$RepoDir = "$PWD")

try {
	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	set-location "$RepoDir"

	if ($CommitID -eq "") { $CommitID = read-host "Enter the Git commit id to cherry-pick" }
	if ($CommitMessage -eq "") { $CommitMessage = read-host "Enter the commit message to use" }
	if ($Branches -eq "") { $Branches = read-host "Enter the branches (separated by spaces)" }
	
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	$BranchArray = $Branches.Split(" ")
	$NumBranches = $BranchArray.Count
	foreach($Branch in $BranchArray) {

		"🍒 Switching to branch $Branch ..."
		& git checkout --recurse-submodules --force $Branch
		if ($lastExitCode -ne "0") { throw "'git checkout $Branch' failed" }

		"🍒 Updating submodules..."
		& git submodule update --init --recursive
		if ($lastExitCode -ne "0") { throw "'git submodule update' failed" }

		"🍒 Cleaning the repository from untracked files..."
		& git clean -fdx -f
		if ($lastExitCode -ne "0") { throw "'git clean -fdx -f' failed" }
			
		& git submodule foreach --recursive git clean -fdx -f
		if ($lastExitCode -ne "0") { throw "'git clean -fdx -f' in submodules failed" }

		"🍒 Pulling latest updates..."
		& git pull --recurse-submodules 
		if ($lastExitCode -ne "0") { throw "'git pull' failed" }

		"🍒 Checking the status..."
		$Result = (git status)
		if ($lastExitCode -ne "0") { throw "'git status' failed" }
		if ("$Result" -notmatch "nothing to commit, working tree clean") { throw "Branch is NOT clean: $Result" }

		"🍒 Cherry picking..."
		& git cherry-pick --no-commit "$CommitID"
		if ($lastExitCode -ne "0") { throw "'git cherry-pick $CommitID' failed" }

		"🍒 Committing..."
		& git commit -m "$CommitMessage"
		if ($lastExitCode -ne "0") { throw "'git commit' failed" }

		"🍒 Pushing..."
		& git push
		if ($lastExitCode -ne "0") { throw "'git push' failed" }
	}
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ cherry picked $CommitID into $NumBranches branches in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
