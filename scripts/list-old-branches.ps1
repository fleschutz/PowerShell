﻿<#
.SYNOPSIS
	Lists old Git branches
.DESCRIPTION
	This PowerShell script lists branches in a Git repository matching: (1) search pattern, (2) already merged, (3) older than 2024
.PARAMETER pathToRepo
	Specifies the path to the Git repository (current working directory by default)
.EXAMPLE
	PS> ./list-old-branches.ps1 C:\Repos\UFA
q#>

param([string]$pathToRepo = "$PWD", [string]$searchPattern = "origin/dev/*")

try {
	"(1/3) Searching for Git executable...    "
        & git --version
        if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

        "(2/3) Checking local repository..."
        if (!(Test-Path "$pathToRepo" -pathType container)) { throw "Can't access repo folder: $pathToRepo" }

	"(3/3) Querying already merged branches with name '$searchPattern'..."
	$branches = $(git -C "$pathToRepo" branch --list --remotes --no-color --no-column --merged HEAD "$searchPattern")
	if ($lastExitCode -ne "0") { throw "'git branch --list' failed" }

	""
	"LAST COMMIT DATE   BRANCH NAME"
	"----------------   -----------"
	foreach($branch in $branches) {
		$branchName = $branch.Trim() # remove leading spaces

		$dateOfLastCommit = (git -C "$pathToRepo" log -1 --format=%cs $branchName)
		if ($dateOfLastCommit -like "2024-*") { continue} # too young

		"$dateOfLastCommit         $branchName"
	}
	exit 0 # success
} catch {
	Write-Error "Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}