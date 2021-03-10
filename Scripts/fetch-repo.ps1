#!/bin/powershell
<#
.SYNTAX         ./fetch-repo.ps1 [<repo-dir>]
.DESCRIPTION	fetches a single Git repository at the current/given directory (including submodules)
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param($RepoDir = "$PWD")

try {
	write-output "Fetching repository $RepoDir at $env:computername ..."

	if (-not(test-path "$RepoDir")) { throw "Repository at $RepoDir is non-existing" }
	set-location "$RepoDir"

	& git --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	& git fetch --recurse-submodules
	if ($lastExitCode -ne "0") { throw "'git fetch --recurse-submodules' failed" }

	& git status
	if ($lastExitCode -ne "0") { throw "'git status' failed" }

	write-host -foregroundColor green "OK - repository $RepoDir has been fetched"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
