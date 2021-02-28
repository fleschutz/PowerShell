#!/bin/powershell
<#
.SYNTAX         ./update-repos.ps1 [<parent-dir>]
.DESCRIPTION	updates all Git repositories under the current/given directory (including submodules)
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param($ParentDir = "$PWD")

try {
	& git --version
} catch {
	write-error "ERROR: can't execute 'git' - make sure Git is installed and available"
	exit 1
}

try {
	set-location $ParentDir
	get-childItem $ParentDir -attributes Directory | foreach-object {
		set-location $_.FullName
		write-host ""
		write-host -nonewline "Updating $($_.FullName)..."

		& git pull --recurse-submodules
		if ($lastExitCode -ne "0") { throw "'git pull --recurse-submodules' failed" }

		set-location ..
	}
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
