<#
.SYNOPSIS
	Switches the branch in a Git repository 
.DESCRIPTION
	This PowerShell script switches to another branch in a Git repository (including submodules).
.PARAMETER BranchName
	Specifies the branch name
.PARAMETER RepoDir
	Specifies the path to the Git repository
.EXAMPLE
	PS> ./switch-branch main C:\MyRepo
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$BranchName = "", [string]$RepoDir = "$PWD")

try {
	if ($BranchName -eq "") { $BranchName = read-host "Enter name of branch to switch to" }
	if ($RepoDir -eq "") { $RepoDir = read-host "Enter path to the Git repository" }

	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	"⏳ Step 1/6 - Searching for Git executable..."
	& git --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	$RepoDir = Resolve-Path "$RepoDir"
	$RepoDirName = (Get-Item "$RepoDir").Name
	"⏳ Step 2/6 - Checking Git repository 📂$RepoDirName..."
	if (-not(Test-Path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }

	$Result = (git status)
	if ($lastExitCode -ne "0") { throw "'git status' in $RepoDir failed with exit code $lastExitCode" }
	if ("$Result" -notmatch "nothing to commit, working tree clean") { throw "Git repository is NOT clean: $Result" }

	"⏳ Step 3/6 - Fetching updates..."
	& git -C "$RepoDir" fetch --all --prune --prune-tags --force
	if ($lastExitCode -ne "0") { throw "'git fetch' failed with exit code $lastExitCode" }

	"⏳ Step 4/6 - Switching branch..."
	& git -C "$RepoDir" checkout --recurse-submodules "$BranchName"
	if ($lastExitCode -ne "0") { throw "'git checkout $BranchName' failed with exit code $lastExitCode" }

	"⏳ Step 5/6 - Pulling updates..."
	& git -C "$RepoDir" pull --recurse-submodules
	if ($lastExitCode -ne "0") { throw "'git pull' failed with exit code $lastExitCode" }

	"⏳ Step 6/6 - Updating submodules..."	
	& git -C "$RepoDir" submodule update --init --recursive
	if ($lastExitCode -ne "0") { throw "'git submodule update' failed with exit code $lastExitCode" }

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ switched 📂$RepoDirName repo to $BranchName branch in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}