#!/bin/powershell
<#
.SYNTAX         ./list-branches.ps1 [<repo-dir>]
.DESCRIPTION	lists the branches of the current/given Git repository 
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param($RepoDir = "$PWD")

try {
	$null = $(git --version)
} catch {
	write-error "ERROR: can't execute 'git' - make sure Git is installed and available"
	exit 1
}

try {
	set-location $RepoDir
	& git branch --list --no-color --no-column
	if ($lastExitCode -ne "0") { throw "'git branch' failed" }

	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
