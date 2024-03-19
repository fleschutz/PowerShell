<#
.SYNOPSIS
	Switches the Git branch
.DESCRIPTION
	This PowerShell script switches to a given branch in a Git repository (including updating submodules).
.PARAMETER branchName
	Specifies the target branch name
.PARAMETER pathToRepo
	Specifies the file path to the local Git repository
.EXAMPLE
	PS> ./switch-branch main C:\Repos\rust
	⏳ (1/6) Searching for Git executable...   git version 2.43.0.windows.1
	⏳ (2/6) Checking Git repository...
	⏳ (3/6) Fetching updates...
	⏳ (4/6) Switching to branch 'main'...
	⏳ (5/6) Pulling updates...
	⏳ (6/6) Updating submodules...
	✔️ Switched 📂rust repository to 'main' branch in 22 sec.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$branchName = "", [string]$pathToRepo = "$PWD")

try {
	if ($branchName -eq "") { $branchName = Read-Host "Enter the branch name to switch to" }
	if ($pathToRepo -eq "") { $pathToRepo = Read-Host "Enter the file path to the Git repository" }

	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "⏳ (1/6) Searching for Git executable...   " -noNewline
	& git --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	Write-Host "⏳ (2/6) Checking Git repository..."
	$pathToRepo = Resolve-Path "$pathToRepo"
	if (-not(Test-Path "$pathToRepo" -pathType container)) { throw "Can't access repo folder: $pathToRepo" }
	$result = (git status)
	if ($lastExitCode -ne "0") { throw "'git status' in $pathToRepo failed with exit code $lastExitCode" }
	if ("$result" -notmatch "nothing to commit, working tree clean") { throw "Git repository is NOT clean: $result" }
	$repoDirName = (Get-Item "$pathToRepo").Name

	"⏳ (3/6) Fetching updates..."
	& git -C "$pathToRepo" fetch --all --prune --prune-tags --force
	if ($lastExitCode -ne "0") { throw "'git fetch' failed with exit code $lastExitCode" }

	"⏳ (4/6) Switching to branch '$branchName'..."
	& git -C "$pathToRepo" checkout --recurse-submodules "$branchName"
	if ($lastExitCode -ne "0") { throw "'git checkout $branchName' failed with exit code $lastExitCode" }

	"⏳ (5/6) Pulling updates..."
	& git -C "$pathToRepo" pull --recurse-submodules
	if ($lastExitCode -ne "0") { throw "'git pull' failed with exit code $lastExitCode" }

	"⏳ (6/6) Updating submodules..."	
	& git -C "$pathToRepo" submodule update --init --recursive
	if ($lastExitCode -ne "0") { throw "'git submodule update' failed with exit code $lastExitCode" }

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✔️ Switched 📂$repoDirName repository to '$branchName' branch in $elapsed sec."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}