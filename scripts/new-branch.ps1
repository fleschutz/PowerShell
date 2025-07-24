﻿<#
.SYNOPSIS
	Creates a new Git branch 
.DESCRIPTION
	This PowerShell script creates a new branch in a local Git repository and switches to it.
.PARAMETER newBranch
	Specifies the new branch name
.PARAMETER path
	Specifies the file path to the local Git repository (current working directory by default)
.EXAMPLE
	PS> ./new-branch.ps1 feature123
	⏳ (1/6) Searching for Git executable...  git version 2.45.0
	⏳ (2/6) Checking local repository...     C:\Repos\rust
	⏳ (3/6) Fetching remote updates...       git@github.org:rust/rust.git
	⏳ (4/6) Creating new branch...
	⏳ (5/6) Pushing updates...
	⏳ (6/6) Updating submodules...
	✅ Repo 'rust' on new branch 'feature123' (based on 'main', took 18s).
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$newBranch = "", [string]$path = "$PWD")

try {
	if ($newBranch -eq "") { $newBranch = Read-Host "Enter the new Git branch name" }

	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	Write-Host "⏳ (1/6) Searching for Git executable...  " -noNewline
	& git --version
	if ($lastExitCode -ne 0) { throw "Can't execute 'git' - make sure Git is installed and available" }

	Write-Host "⏳ (2/6) Checking local repository...     $path"
	if (-not(Test-Path "$path" -pathType container)) { throw "Can't access repo folder: $path" }
	$result = (git -C "$path" status)
        if ($lastExitCode -ne 0) { throw "'git status' in $path failed with exit code $lastExitCode" }
	$repoName = (Get-Item "$path").Name

	Write-Host "⏳ (3/6) Fetching remote updates...       " -noNewline
	& git -C "$path" remote get-url origin
        if ($lastExitCode -ne 0) { throw "'git remote get-url origin' failed with exit code $lastExitCode" }

	& git -C "$path" fetch --all --recurse-submodules --prune --prune-tags --force
	if ($lastExitCode -ne 0) { throw "'git fetch' failed with exit code $lastExitCode" }

	$currentBranch = (git -C "$path" rev-parse --abbrev-ref HEAD)
	if ($lastExitCode -ne 0) { throw "'git rev-parse' failed with exit code $lastExitCode" }

	"⏳ (4/6) Creating new branch..."
	& git -C "$path" checkout -b "$newBranch"
	if ($lastExitCode -ne 0) { throw "'git checkout -b $newBranch' failed with exit code $lastExitCode" }

	"⏳ (5/6) Pushing updates..."
	& git -C "$path" push origin "$newBranch"
	if ($lastExitCode -ne 0) { throw "'git push origin $newBranch' failed with exit code $lastExitCode" }

	"⏳ (6/6) Updating submodules..."
	& git -C "$path" submodule update --init --recursive
	if ($lastExitCode -ne 0) { throw "'git submodule update' failed with exit code $lastExitCode" }

	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Repo '$repoName' on new branch '$newBranch' (based on '$currentBranch', took $($elapsed)s)."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) in script line $($_.InvocationInfo.ScriptLineNumber)."
	exit 1
}
