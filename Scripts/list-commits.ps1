#!/bin/powershell
<#
.SYNTAX         ./list-commits.ps1 [<repo-dir>] [<format>]
.DESCRIPTION	lists all commits of the current/given Git repository 
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param($RepoDir = "$PWD", $Format = "compact")

try {
	write-progress "Fetching changes in Git repository $RepoDir ..."

	if (-not(test-path "$RepoDir")) { throw "Can't access Git repository directory: $RepoDir" }
	set-location $RepoDir

	& git --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	& git fetch --all --recurse-submodules
	if ($lastExitCode -ne "0") { throw "'git fetch --all --recurse-submodules' failed" }

	write-output "List of commits in Git repository $($RepoDir):"
	if ($Format -eq "compact") {
		& git log --graph --pretty=format:'%Cred%h%Creset%C(yellow)%d%Creset %s %C(bold blue)by %an %cr%Creset' --abbrev-commit
	} else {
		& git log
	}
	
	if ($lastExitCode -ne "0") { throw "'git log' failed" }

	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
