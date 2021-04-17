#!/usr/bin/pwsh
<#
.SYNTAX       clone-repos.ps1 [<target-dir>]
.DESCRIPTION  clones well-known Git repositories into the current/given directory.
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($TargetDir = "$PWD")

try {
	& git --version
} catch {
	write-error "ERROR: can't execute 'git' - make sure Git is installed and available"
	exit 1
}

try {
	$PathToRepo = "$PSScriptRoot/.."
	$Table = import-csv "$PathToRepo/Data/repos.csv"

	set-location $TargetDir
	foreach($Row in $Table) {
		$URL = $Row.URL
		$Directory = $Row.Directory
		write-output ""
		if (Test-Path $Directory) {
			write-output "Skipping existing $Directory ..."
			continue
		}
		write-output "⏳ Cloning from $URL..."
		& git clone --recurse-submodules $URL
		if ($lastExitCode -ne "0") { throw "'git clone $URL' failed" }
	}
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
