<#
.SYNOPSIS
	Creates a new branch 
.DESCRIPTION
	This PowerShell script creates a new Git branch in a local repository and switches to it.
.PARAMETER newBranch
	Specifies the new Git branch name (check the allowed characters)
.PARAMETER pathToRepo
	Specifies the file path to the local repository (current working directory per default)
.EXAMPLE
	PS> ./new-branch.ps1 test123 C:\Repos\rust
	⏳ (1/6) Searching for Git executable...  git version 2.42.0.windows.2
	⏳ (2/6) Checking Git repository...
	⏳ (3/6) Fetching updates...
	⏳ (4/6) Creating new branch...
	⏳ (5/6) Pushing updates...
	⏳ (6/6) Updating submodules...
	✔️ Created branch 'test123' in 📂rust repository in 18 sec (based on 'main')
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$newBranch = "", [string]$pathToRepo = "$PWD")

try {
	if ($newBranch -eq "") { $newBranch = Read-Host "Enter the new Git branch name" }

	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "⏳ (1/6) Searching for Git executable...  " -noNewline
	& git --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	Write-Host "⏳ (2/6) Checking Git repository..."
	if (-not(Test-Path "$pathToRepo" -pathType container)) { throw "Can't access directory: $pathToRepo" }
	$repoName = (Get-Item "$pathToRepo").Name

	"⏳ (3/6) Fetching updates..."
	& git -C "$pathToRepo" fetch --all --recurse-submodules --prune --prune-tags --force
	if ($lastExitCode -ne "0") { throw "'git fetch' failed with exit code $lastExitCode" }

	$currentBranch = (git -C "$pathToRepo" rev-parse --abbrev-ref HEAD)
	if ($lastExitCode -ne "0") { throw "'git rev-parse' failed with exit code $lastExitCode" }

	"⏳ (4/6) Creating new branch..."
	& git -C "$pathToRepo" checkout -b "$newBranch"
	if ($lastExitCode -ne "0") { throw "'git checkout -b $newBranch' failed with exit code $lastExitCode" }

	"⏳ (5/6) Pushing updates..."
	& git -C "$pathToRepo" push origin "$newBranch"
	if ($lastExitCode -ne "0") { throw "'git push origin $newBranch' failed with exit code $lastExitCode" }

	"⏳ (6/6) Updating submodules..."
	& git -C "$pathToRepo" submodule update --init --recursive
	if ($lastExitCode -ne "0") { throw "'git submodule update' failed with exit code $lastExitCode" }

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✔️ Created branch '$newBranch' in 📂$repoName repository in $elapsed sec (based on '$currentBranch')"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}