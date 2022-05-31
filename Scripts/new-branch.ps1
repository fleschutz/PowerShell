<#
.SYNOPSIS
	Creates a new Git branch 
.DESCRIPTION
	This PowerShell script creates and switches to a new branch in a Git repository.
.PARAMETER NewBranchName
	Specifies the new branch name
.PARAMETER RepoDir
	Specifies the path to the Git repository (current working directory per default)
.EXAMPLE
	PS> ./new-branch test123
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$NewBranchName = "", [string]$RepoDir = "$PWD")

try {
	if ($NewBranchName -eq "") { $NewBranchName = read-host "Enter new branch name" }

	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	"⏳ Step 1/5: Checking requirements... "
	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }

	$null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	"⏳ Step 2/5: Fetching updates..."
	& git -C "$RepoDir" fetch --all --recurse-submodules --prune --prune-tags --force
	if ($lastExitCode -ne "0") { throw "'git fetch' failed with exit code $lastExitCode" }

	$CurrentBranchName = (git -C "$RepoDir" rev-parse --abbrev-ref HEAD)
	if ($lastExitCode -ne "0") { throw "'git rev-parse' failed with exit code $lastExitCode" }

	"⏳ Step 3/5: Creating branch '$NewBranchName'..."
	& git -C "$RepoDir" checkout -b "$NewBranchName"
	if ($lastExitCode -ne "0") { throw "'git checkout -b $NewBranchName' failed with exit code $lastExitCode" }

	"⏳ Step 4/5: Pushing updates..."
	& git -C "$RepoDir" push origin "$NewBranchName"
	if ($lastExitCode -ne "0") { throw "'git push origin $NewBranchName' failed with exit code $lastExitCode" }

	"⏳ Step 5/5: Updating submodules..."
	& git -C "$RepoDir" submodule update --init --recursive
	if ($lastExitCode -ne "0") { throw "'git submodule update' failed with exit code $lastExitCode" }

	$RepoDirName = (get-item "$RepoDir").Name
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ new '$NewBranchName' branch created in 📂$RepoDirName repo in $Elapsed sec (based on '$CurrentBranchName' branch)"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
