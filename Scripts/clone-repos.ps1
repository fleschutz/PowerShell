#!/usr/bin/pwsh
<#
.SYNTAX       clone-repos.ps1 [<target-dir>]
.DESCRIPTION  clones well-known Git repositories into the current/given directory.
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($TargetDir = "$PWD")

try {
	if (-not(test-path "$TargetDir" -pathType container)) { throw "Can't access directory: $TargetDir" }

	$Null = (git --version)
	if ($lastExitCode -ne "0") { throw "Can't execute 'git' - make sure Git is installed and available" }

	$Table = import-csv "$PSScriptRoot/../Data/git-repositories.csv"

	foreach($Row in $Table) {
		$URL = $Row.URL
		$Directory = $Row.Directory
		if (Test-Path "$TargetDir/$Directory") {
			"Skipping existing $Directory..."
			continue
		}
		"⏳ Cloning $URL..."
		& git clone --recurse-submodules "$URL" "$TargetDir/$Directory"
		if ($lastExitCode -ne "0") { throw "'git clone $URL' failed" }
		""
	}
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
