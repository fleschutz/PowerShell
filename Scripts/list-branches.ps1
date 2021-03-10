#!/bin/powershell
<#
.SYNTAX         ./list-branches.ps1 [<repo-dir>] [<pattern>]
.DESCRIPTION	lists all branches of the current/given Git repository 
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param($RepoDir = "$PWD", $Pattern = "*")

try {
	write-output "Listing Git branches of repository $RepoDir ..."

	if (-not(test-path "$RepoDir")) { throw "Can't access Git repository at: $RepoDir" }
	set-location $RepoDir

	$null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	& git fetch --all --recurse-submodules
	if ($lastExitCode -ne "0") { throw "'git fetch --all --recurse-submodules' failed" }

	$Branches = $(git branch --list --remotes --no-color --no-column)
	if ($lastExitCode -ne "0") { throw "'git branch --list' failed" }

	foreach($Branch in $Branches) {
		if ("$Branch" -match "origin/HEAD") { continue }
		$BranchName = $Branch.substring(9)
		if ("$BranchName" -notlike "$Pattern") { continue }
		write-output "$BranchName"
	}
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
