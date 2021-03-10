#!/bin/powershell
<#
.SYNTAX         ./list-commits.ps1 [<repo-dir>] [<branch>]
.DESCRIPTION	lists all commits of the current/given Git repository in the given branch
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param($RepoDir = "$PWD", $Branch = "main")

try {
	write-output "Listing commits of Git repository $RepoDir ..."

	if (-not(test-path "$RepoDir")) { throw "Can't access Git repository at: $RepoDir" }
	set-location $RepoDir

	$null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	& git switch --recurse-submodules $Branch
	if ($lastExitCode -ne "0") { throw "'git switch --recurse-submodules $Branch' failed" }

	& git submodule update --init --recursive
	if ($lastExitCode -ne "0") { throw "'git submodule update' failed" }

	& git pull --recurse-submodules 
	if ($lastExitCode -ne "0") { throw "'git pull' failed" }

	& git log
	if ($lastExitCode -ne "0") { throw "'git log' failed" }

	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
