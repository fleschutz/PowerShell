<#
.SYNOPSIS
	Switches the branch in a Git repository (including submodules)
.DESCRIPTION
	This script switches to another branch in a Git repository (including submodules).
.PARAMETER BranchName
	Specifies the branch name
.PARAMETER RepoDir
	Specifies the path to the Git repository
.EXAMPLE
	PS> ./switch-branch main C:\MyRepo
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$BranchName = "", [string]$RepoDir = "$PWD")

try {
	if ($BranchName -eq "") { $BranchName = read-host "Enter name of branch to switch to" }

	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	"⏳ Checking requirements [step 1/3]... "
	$RepoDir = resolve-path "$RepoDir"
	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	set-location "$RepoDir"

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	$Result = (git status)
	if ($lastExitCode -ne "0") { throw "'git status' failed in $RepoDir" }
	if ("$Result" -notmatch "nothing to commit, working tree clean") { throw "Git repository is NOT clean: $Result" }

	"⏳ Fetching latest updates and switching branch [step 2/3]..."
	& git fetch --all --recurse-submodules --prune --prune-tags --force
	if ($lastExitCode -ne "0") { throw "'git fetch' failed" }

	& git checkout --recurse-submodules "$BranchName"
	if ($lastExitCode -ne "0") { throw "'git checkout $BranchName' failed" }

	"⏳ Pulling updates and updating submodules [step 3/3]..."
	& git pull --recurse-submodules
	if ($lastExitCode -ne "0") { throw "'git pull' failed" }

	& git submodule update --init --recursive
	if ($lastExitCode -ne "0") { throw "'git submodule update' failed" }

	$RepoDirName = (get-item "$RepoDir").Name
	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ switched Git repository 📂$RepoDirName to $BranchName branch in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
