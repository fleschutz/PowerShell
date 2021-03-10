#!/bin/powershell
<#
.SYNTAX         ./fetch-repos.ps1 [<parent-dir>]
.DESCRIPTION	fetches all Git repositories under the current/given directory (including submodules)
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param($ParentDir = "$PWD")

try {
	$null = $(git --version)
} catch {
	write-error "ERROR: can't execute 'git' - make sure Git is installed and available"
	exit 1
}

try {
	write-progress "Fetching repositories under $ParentDir ..."
	set-location $ParentDir
	get-childItem $ParentDir -attributes Directory | foreach-object {
		set-location $_.FullName

		& git fetch --all --recurse-submodules
		if ($lastExitCode -ne "0") { throw "'git fetch --recurse-submodules' failed" }

		set-location ..
	}

	write-host -foregroundColor green "OK - fetched repositories under $ParentDir"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
