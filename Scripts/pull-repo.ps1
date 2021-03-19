#!/bin/powershell
<#
.SYNTAX         ./pull-repo.ps1 [<repo-dir>]
.DESCRIPTION	pulls updates for the current/given Git repository (including submodules)
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param($RepoDir = "$PWD")

try {
	write-output "Pulling updates for Git repository $RepoDir ..."

	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	set-location "$RepoDir"

	& git --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	& git pull --recurse-submodules
	if ($lastExitCode -ne "0") { throw "'git pull --recurse-submodules' failed" }

	& git status
	if ($lastExitCode -ne "0") { throw "'git status' failed" }

	write-host -foregroundColor green "OK - pulled updates for Git repository $RepoDir"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
