#!/bin/powershell
<#
.SYNTAX         ./switch-branch.ps1 [<branch>]
.DESCRIPTION	switches to the given Git branch
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param($Branch = "")

try {
	& git --version
} catch {
	write-error "ERROR: can't execute 'git' - make sure Git is installed and available"
	exit 1
}

try {
	if ($Branch -eq "") {
		$Branch = read-host "Enter branch name to switch to"
	}

	& git switch --recurse-submodules $Branch
	if ($lastExitCode -ne "0") { throw "'git switch --recurse-submodules $Branch' failed" }

	& git pull --recurse-submodules 
	if ($lastExitCode -ne "0") { throw "'git pull --recurse-submodules' failed" }

	& git status
	if ($lastExitCode -ne "0") { throw "'git status' failed" }

	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
