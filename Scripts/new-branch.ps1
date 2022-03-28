<#
.SYNOPSIS
	Create a new Git branch 
.DESCRIPTION
	This PowerShell script creates and switches to a new branch in a Git repository.
.PARAMETER BranchName
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

param([string]$BranchName = "", [string]$RepoDir = "$PWD")

try {
	if ($BranchName -eq "") { $BranchName = read-host "Enter new branch name" }

	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	"⏳ Step 1/5: Checking requirements... "
	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }

	& git --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	"⏳ Step 2/5: Fetching updates..."
	& git -C "$RepoDir" fetch --all --recurse-submodules --prune --prune-tags --force
	if ($lastExitCode -ne "0") { throw "'git fetch' failed" }

	"⏳ Step 3/5: Creating new branch '$BranchName'..."
	& git -C "$RepoDir" checkout -b "$BranchName"
	if ($lastExitCode -ne "0") { throw "'git checkout -b $BranchName' failed" }

	"⏳ Step 4/5: Pushing updates..."
	& git -C "$RepoDir" push origin "$BranchName"
	if ($lastExitCode -ne "0") { throw "'git push origin $BranchName' failed" }

	"⏳ Step 5/5: Updating submodules..."
	& git -C "$RepoDir" submodule update --init --recursive
	if ($lastExitCode -ne "0") { throw "'git submodule update' failed" }

	$RepoDirName = (get-item "$RepoDir").Name
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ created new branch '$BranchName' in Git repository 📂$RepoDirName in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}