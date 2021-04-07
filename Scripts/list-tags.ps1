#!/usr/bin/pwsh
<#
.SYNTAX       ./list-tags.ps1 [<repo-dir>] [<pattern>]
.DESCRIPTION  lists all tags in the current/given Git repository 
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($RepoDir = "$PWD", $Pattern="*")

try {
	write-output "Fetching updates for Git repository $RepoDir ..."

	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	set-location "$RepoDir"

	& git --version
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	& git fetch --all --recurse-submodules
	if ($lastExitCode -ne "0") { throw "'git fetch --all --recurse-submodules' failed" }

	write-output ""
	write-output "List of Git Tags"
	write-output "----------------"

	& git tag --list "$Pattern"
	if ($lastExitCode -ne "0") { throw "'git tag --list' failed" }

	write-output ""
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
