﻿<#
.SYNOPSIS
	Creates a new tag in a Git repository
.DESCRIPTION
	This PowerShell script creates a new tag in a Git repository.
.PARAMETER TagName
	Specifies the new tag name
.PARAMETER RepoDir
	Specifies the path to the Git repository
.EXAMPLE
	PS> ./new-tag.ps1 v1.7
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$TagName = "", [string]$RepoDir = "$PWD")

try {
	if ($TagName -eq "") { $TagName = read-host "Enter new tag name" }

	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	set-location "$RepoDir"

	$Null = (git --version)
	if ($lastExitCode -ne 0) { throw "Can't execute 'git' - make sure Git is installed and available" }

	$Result = (git status)
	if ($lastExitCode -ne 0) { throw "'git status' failed in $RepoDir" }
	if ("$Result" -notmatch "nothing to commit, working tree clean") { throw "Repository is NOT clean: $Result" }

	& "$PSScriptRoot/fetch-repo.ps1"
	if ($lastExitCode -ne 0) { throw "Script 'fetch-repo.ps1' failed" }

	& git tag "$TagName"
	if ($lastExitCode -ne 0) { throw "Error: 'git tag $TagName' failed!" }

	& git push origin "$TagName"
	if ($lastExitCode -ne 0) { throw "Error: 'git push origin $TagName' failed!" }

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✅ Created new tag '$TagName' in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) in script line $($_.InvocationInfo.ScriptLineNumber)."
	exit 1
}
