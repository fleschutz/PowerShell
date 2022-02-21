<#
.SYNOPSIS
	Create a New Git Branch 
.DESCRIPTION
	This PowerShell script creates and switches to a new branch in a Git repository.
.PARAMETER BranchName
	Specifies the branch name (or needs to be entered)
.PARAMETER RepoDir
	Specifies the path to the Git repository (or working directory per default)
.EXAMPLE
	PS> ./new-branch test123
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$BranchName = "", [string]$RepoDir = "$PWD")

try {
	if ($BranchName -eq "") { $BranchName = read-host "Enter new branch name" }

	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	"⏳ Step 1/4: Checking requirements... "
	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	set-location "$RepoDir"

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	$RepoDirName = (get-item "$RepoDir").Name
	"⏳ Step 2/4: Fetching updates..."
	& git fetch --all --recurse-submodules --prune --prune-tags --force
	if ($lastExitCode -ne "0") { throw "'git fetch' failed" }

	"⏳ Step 3/4: Checkout and push new branch..."
	& git checkout -b "$BranchName"
	if ($lastExitCode -ne "0") { throw "'git checkout -b $BranchName' failed" }

	& git push origin "$BranchName"
	if ($lastExitCode -ne "0") { throw "'git push origin $BranchName' failed" }

	"⏳ Step 4/4: Updating submodules..."
	& git submodule update --init --recursive
	if ($lastExitCode -ne "0") { throw "'git submodule update' failed" }

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ created new branch '$BranchName' in Git repository 📂$RepoDirName in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}