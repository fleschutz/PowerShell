#!/bin/powershell
<#
.SYNTAX         ./clean-branch.ps1 [<repo-dir>]
.DESCRIPTION	cleans the current/given Git repository from generated files (including submodules, e.g. for a fresh build)
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param($RepoDir = "$PWD")

try {
	& git --version
} catch {
	write-error "ERROR: can't execute 'git' - make sure Git is installed and available"
	exit 1
}

try {
	write-progress "Cleaning Git repository $RepoDir from generated files ..."

	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	set-location "$RepoDir"
	
	& git clean -fdx # force + recurse into dirs + don't use the standard ignore rules
	if ($lastExitCode -ne "0") { throw "'git clean -fdx' failed" }

	& git submodule foreach --recursive git clean -fdx 
	if ($lastExitCode -ne "0") { throw "'git clean -fdx' in submodules failed" }

	write-host -foregroundColor green "OK - cleaned Git repository $RepoDir from generated files"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
