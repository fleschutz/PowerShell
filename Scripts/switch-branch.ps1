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
	Author: Markus Fleschutz / License: CC0
#>

param([string]$BranchName = "", [string]$RepoDir = "$PWD")

try {
	if ($BranchName -eq "") { $BranchName = read-host "Enter name of branch to switch to" }

	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	"⏳ Step 1/5: Checking requirements... "
	$RepoDir = resolve-path "$RepoDir"
	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	set-location "$RepoDir"

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	$Result = (git status)
	if ($lastExitCode -ne "0") { throw "'git status' failed in $RepoDir" }
	if ("$Result" -notmatch "nothing to commit, working tree clean") { throw "Git repository is NOT clean: $Result" }

	"⏳ Step 2/5: Fetching latest updates..."
	& git fetch --all --recurse-submodules --prune --prune-tags --force
	if ($lastExitCode -ne "0") { throw "'git fetch' failed" }

	"⏳ Step 3/5: Switching branch..."
	& git checkout --recurse-submodules "$BranchName"
	if ($lastExitCode -ne "0") { throw "'git checkout $BranchName' failed" }

	"⏳ Step 4/5: Pulling updates..."
	& git pull --recurse-submodules
	if ($lastExitCode -ne "0") { throw "'git pull' failed" }

	"⏳ Step 5/5: Updating submodules..."	
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
