<#
.SYNOPSIS
	Creates a new Git branch 
.DESCRIPTION
	This PowerShell script creates a new branch in a local Git repository and switches to it.
.PARAMETER newBranch
	Specifies the new branch name
.PARAMETER repoPath
	Specifies the path to the Git repository (current working directory per default)
.EXAMPLE
	PS> ./new-branch.ps1 test123 C:\MyRepo
	⏳ (1/6) Searching for Git executable...  git version 2.42.0.windows.2
	⏳ (2/6) Checking local repository...
	⏳ (3/6) Fetching latest updates...
	⏳ (4/6) Creating new branch...
	⏳ (5/6) Pushing updates...
	⏳ (6/6) Updating submodules...
	✔️ Created branch 'test123' in repo 📂MyRepo (based on 'main') in 18 sec
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$newBranch = "", [string]$repoPath = "$PWD")

try {
	if ($newBranch -eq "") { $newBranch = Read-Host "Enter the new branch name" }

	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "⏳ (1/6) Searching for Git executable...  " -noNewline
	& git --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	Write-Host "⏳ (2/6) Checking local repository..."
	if (-not(Test-Path "$repoPath" -pathType container)) { throw "Can't access directory: $repoPath" }
	$repoPathName = (Get-Item "$repoPath").Name

	"⏳ (3/6) Fetching latest updates..."
	& git -C "$repoPath" fetch --all --recurse-submodules --prune --prune-tags --force
	if ($lastExitCode -ne "0") { throw "'git fetch' failed with exit code $lastExitCode" }

	$currentBranch = (git -C "$repoPath" rev-parse --abbrev-ref HEAD)
	if ($lastExitCode -ne "0") { throw "'git rev-parse' failed with exit code $lastExitCode" }

	"⏳ (4/6) Creating new branch..."
	& git -C "$repoPath" checkout -b "$newBranch"
	if ($lastExitCode -ne "0") { throw "'git checkout -b $newBranch' failed with exit code $lastExitCode" }

	"⏳ (5/6) Pushing updates..."
	& git -C "$repoPath" push origin "$newBranch"
	if ($lastExitCode -ne "0") { throw "'git push origin $newBranch' failed with exit code $lastExitCode" }

	"⏳ (6/6) Updating submodules..."
	& git -C "$repoPath" submodule update --init --recursive
	if ($lastExitCode -ne "0") { throw "'git submodule update' failed with exit code $lastExitCode" }

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✔️ Created branch '$newBranch' in repo 📂$repoPathName (based on '$currentBranch') in $elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}