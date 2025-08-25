<#
.SYNOPSIS
	Lists Git branches
.DESCRIPTION
	This PowerShell script lists branches in a Git repository - either all (default) or by a search pattern.
.PARAMETER pathToRepo
	Specifies the path to the Git repository (current working directory by default)
.PARAMETER searchPattern
	Specifies the search pattern ("*", anything by default)
.EXAMPLE
	PS> ./list-branches.ps1

	List of Git Branches
	--------------------
	main
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$pathToRepo = "$PWD", [string]$searchPattern = "*")

try {
	if (-not(Test-Path "$pathToRepo" -pathType container)) { throw "Can't access repo folder '$pathToRepo' - maybe a typo or missing folder permissions?" }

	$null = (git --version)
	if ($lastExitCode -ne 0) { throw "Can't execute 'git' - make sure Git is installed and available" }

	& git -C "$pathToRepo" fetch 
	if ($lastExitCode -ne 0) { throw "'git fetch' failed" }

	$branches = $(git -C "$pathToRepo" branch --list --remotes --no-color --no-column)
	if ($lastExitCode -ne 0) { throw "'git branch --list' failed" }

	""
	"List of Git Branches"
	"--------------------"
	foreach($branch in $branches) {
		if ("$branch" -match "origin/HEAD") { continue }
		$branchName = $branch.substring(9)
		if ("$branchName" -notlike "$searchPattern") { continue }
		"$branchName"
	}
	""
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
