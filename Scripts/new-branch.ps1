<#
.SYNOPSIS
	Creates a new Git branch 
.DESCRIPTION
	This PowerShell script creates a new branch in a Git repository and switches to it.
.PARAMETER NewBranchName
	Specifies the new branch name
.PARAMETER RepoDir
	Specifies the path to the Git repository (current working directory per default)
.EXAMPLE
	PS> ./new-branch test123
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$NewBranchName = "", [string]$RepoDir = "$PWD")

try {
	if ($NewBranchName -eq "") { $NewBranchName = Read-Host "Enter new branch name" }

	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "⏳ (1/6) Searching for Git executable...  " -noNewline
	& git --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	Write-Host "⏳ (2/6) Checking repository...           📂$RepoDir"
	if (-not(Test-Path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	$RepoDirName = (Get-Item "$RepoDir").Name

	"⏳ (3/6) Fetching latest updates..."
	& git -C "$RepoDir" fetch --all --recurse-submodules --prune --prune-tags --force
	if ($lastExitCode -ne "0") { throw "'git fetch' failed with exit code $lastExitCode" }

	$CurrentBranchName = (git -C "$RepoDir" rev-parse --abbrev-ref HEAD)
	if ($lastExitCode -ne "0") { throw "'git rev-parse' failed with exit code $lastExitCode" }

	"⏳ (4/6) Creating branch..."
	& git -C "$RepoDir" checkout -b "$NewBranchName"
	if ($lastExitCode -ne "0") { throw "'git checkout -b $NewBranchName' failed with exit code $lastExitCode" }

	"⏳ (5/6) Pushing updates..."
	& git -C "$RepoDir" push origin "$NewBranchName"
	if ($lastExitCode -ne "0") { throw "'git push origin $NewBranchName' failed with exit code $lastExitCode" }

	"⏳ (6/6) Updating submodules..."
	& git -C "$RepoDir" submodule update --init --recursive
	if ($lastExitCode -ne "0") { throw "'git submodule update' failed with exit code $lastExitCode" }

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ created branch '$NewBranchName' in repo 📂$RepoDirName (based on '$CurrentBranchName') in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}