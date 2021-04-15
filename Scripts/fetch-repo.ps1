#!/usr/bin/pwsh
<#
.SYNTAX       fetch-repo.ps1 [<repo-dir>]
.DESCRIPTION  fetches updates for the current/given Git repository (including submodules)
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($RepoDir = "$PWD")

try {
	"Fetching updates for Git repository $($RepoDir)..."

	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	set-location "$RepoDir"

	& git fetch --all --recurse-submodules --jobs=4
	if ($lastExitCode -ne "0") {
		# retry once:
		start-sleep -milliseconds 1000
		& git fetch --all --recurse-submodules --jobs=1
		if ($lastExitCode -ne "0") { throw "'git fetch' failed (twice)" }
	}
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
