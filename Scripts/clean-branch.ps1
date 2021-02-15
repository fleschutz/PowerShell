#!/bin/powershell
<#
.SYNTAX         ./clean-branch.ps1
.DESCRIPTION	cleans the current Git branch (and submodules) from generated files
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

try {
	& git --version
} catch {
	write-error "ERROR: can't execute 'git' - make sure Git is installed and available"
	exit 1
}

try {
	& git clean --force -d -x
	if ($lastExitCode -ne "0") { throw "'git clean' failed" }

	& git submodule foreach --recursive git clean --force -d -x
	if ($lastExitCode -ne "0") { throw "'git clean' in submodules failed" }

	& git status
	if ($lastExitCode -ne "0") { throw "'git status' failed" }

	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
