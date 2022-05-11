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

	"⏳ Step 1/5: Checking requirements... "
	$RepoDir = resolve-path "$RepoDir"
	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	set-location "$RepoDir"

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	$Result = (git status)
	if ($lastExitCode -ne "0") { throw "'git status' in $RepoDir failed with exit code $lastExitCode" }
	if ("$Result" -notmatch "nothing to commit, working tree clean") { throw "Git repository is NOT clean: $Result" }

	"⏳ Step 2/5: Fetching updates..."
	& git fetch --all --recurse-submodules --prune --prune-tags --force
	if ($lastExitCode -ne "0") { throw "'git fetch --all' failed with exit code $lastExitCode" }

	"⏳ Step 3/5: Switching branch..."
	& git checkout --recurse-submodules "$BranchName"
	if ($lastExitCode -ne "0") { throw "'git checkout $BranchName' failed with exit code $lastExitCode" }

	"⏳ Step 4/5: Pulling updates..."
	& git pull --recurse-submodules
	if ($lastExitCode -ne "0") { throw "'git pull' failed with exit code $lastExitCode" }

	"⏳ Step 5/5: Updating submodules..."	
	& git submodule update --init --recursive
	if ($lastExitCode -ne "0") { throw "'git submodule update --init --recursive' failed with exit code $lastExitCode" }

	$RepoDirName = (get-item "$RepoDir").Name
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ switched to '$BranchName' in 📂$RepoDirName repo in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
