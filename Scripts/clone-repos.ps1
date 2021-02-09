#!/bin/powershell
<#
.SYNTAX         ./clone-repos.ps1
.DESCRIPTION	clones well-known Git repositories into the current directory.
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

$PathToRepo = "$PSScriptRoot/.."

try {
	$Table = import-csv "$PathToRepo/Data/repos.csv"

	foreach($Row in $Table) {
		$URL = $Row.URL
		$Directory = $Row.Directory
		write-output ""
		if (Test-Path($Directory)) {
			write-output "Skipping $Directory (already existent) ..."
			continue
		}
		write-output "Cloning from $URL..."
		git clone --recurse-submodules $URL
	}
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
