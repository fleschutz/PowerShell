#!/bin/powershell
<#
.SYNTAX         ./switch-branch.ps1 [<branch>]
.DESCRIPTION	switches the current Git repository to the given branch (including submodules)
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param($Branch = "")

if ($Branch -eq "") {
	$Branch = read-host "Enter branch name to switch to"
}

try {
	& git --version
} catch {
	write-error "ERROR: can't execute 'git' - make sure Git is installed and available"
	exit 1
}

try {
	& git switch --recurse-submodules $Branch
	if ($lastExitCode -ne "0") { throw "'git switch --recurse-submodules $Branch' failed" }

	& git submodule update --init --recursive
	if ($lastExitCode -ne "0") { throw "'git submodule update' failed" }

	& git pull --recurse-submodules 
	if ($lastExitCode -ne "0") { throw "'git pull' failed" }

	& git status
	if ($lastExitCode -ne "0") { throw "'git status' failed" }

	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
