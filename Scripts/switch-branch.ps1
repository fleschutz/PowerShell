<#
.SYNOPSIS
	Switches the Git branch
.DESCRIPTION
	This PowerShell script switches to another branch in a Git repository (including submodules).
.PARAMETER BranchName
	Specifies the branch name
.PARAMETER RepoDir
	Specifies the path to the local Git repository
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
	if ($RepoDir -eq "") { $RepoDir = read-host "Enter path to the local Git repository" }

	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "⏳ (1/6) Searching for Git executable...   " -noNewline
	& git --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	Write-Host "⏳ (2/6) Checking local repository...      📂$RepoDir"
	$RepoDir = Resolve-Path "$RepoDir"
	if (-not(Test-Path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	$Result = (git status)
	if ($lastExitCode -ne "0") { throw "'git status' in $RepoDir failed with exit code $lastExitCode" }
	if ("$Result" -notmatch "nothing to commit, working tree clean") { throw "Git repository is NOT clean: $Result" }
	$RepoDirName = (Get-Item "$RepoDir").Name

	"⏳ (3/6) Fetching updates..."
	& git -C "$RepoDir" fetch --all --prune --prune-tags --force
	if ($lastExitCode -ne "0") { throw "'git fetch' failed with exit code $lastExitCode" }

	"⏳ (4/6) Switching to branch '$BranchName'..."
	& git -C "$RepoDir" checkout --recurse-submodules "$BranchName"
	if ($lastExitCode -ne "0") { throw "'git checkout $BranchName' failed with exit code $lastExitCode" }

	"⏳ (5/6) Pulling updates..."
	& git -C "$RepoDir" pull --recurse-submodules
	if ($lastExitCode -ne "0") { throw "'git pull' failed with exit code $lastExitCode" }

	"⏳ (6/6) Updating submodules..."	
	& git -C "$RepoDir" submodule update --init --recursive
	if ($lastExitCode -ne "0") { throw "'git submodule update' failed with exit code $lastExitCode" }

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ switched repo 📂$RepoDirName to branch '$BranchName' in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}