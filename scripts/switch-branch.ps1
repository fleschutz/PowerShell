<#
.SYNOPSIS
	Switches the Git branch
.DESCRIPTION
	This PowerShell script switches to another branch in a Git repository (including submodules).
.PARAMETER branchName
	Specifies the branch name
.PARAMETER repoDir
	Specifies the path to the local Git repository
.EXAMPLE
	PS> ./switch-branch main C:\MyRepo
	⏳ (1/6) Searching for Git executable...   git version 2.42.0.windows.1
	⏳ (2/6) Checking local repository...
	⏳ (3/6) Fetching updates...
	⏳ (4/6) Switching to branch 'main'...
	⏳ (5/6) Pulling updates...
	⏳ (6/6) Updating submodules...
	✔️ Switched repo 📂MyRepo to branch 'main' in 22 sec
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$branchName = "", [string]$repoDir = "$PWD")

try {
	if ($branchName -eq "") { $branchName = Read-Host "Enter the branch name to switch to" }
	if ($repoDir -eq "") { $repoDir = Read-Host "Enter the path to the local Git repository" }

	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "⏳ (1/6) Searching for Git executable...   " -noNewline
	& git --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	Write-Host "⏳ (2/6) Checking local repository..."
	$repoDir = Resolve-Path "$repoDir"
	if (-not(Test-Path "$repoDir" -pathType container)) { throw "Can't access directory: $repoDir" }
	$Result = (git status)
	if ($lastExitCode -ne "0") { throw "'git status' in $repoDir failed with exit code $lastExitCode" }
	if ("$Result" -notmatch "nothing to commit, working tree clean") { throw "Git repository is NOT clean: $Result" }
	$repoDirName = (Get-Item "$repoDir").Name

	"⏳ (3/6) Fetching latest updates..."
	& git -C "$repoDir" fetch --all --prune --prune-tags --force
	if ($lastExitCode -ne "0") { throw "'git fetch' failed with exit code $lastExitCode" }

	"⏳ (4/6) Switching to branch '$branchName'..."
	& git -C "$repoDir" checkout --recurse-submodules "$branchName"
	if ($lastExitCode -ne "0") { throw "'git checkout $branchName' failed with exit code $lastExitCode" }

	"⏳ (5/6) Pulling updates..."
	& git -C "$repoDir" pull --recurse-submodules
	if ($lastExitCode -ne "0") { throw "'git pull' failed with exit code $lastExitCode" }

	"⏳ (6/6) Updating submodules..."	
	& git -C "$repoDir" submodule update --init --recursive
	if ($lastExitCode -ne "0") { throw "'git submodule update' failed with exit code $lastExitCode" }

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ Switched repo 📂$repoDirName to branch '$branchName' in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}