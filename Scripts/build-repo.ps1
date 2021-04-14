#!/usr/bin/pwsh
<#
.SYNTAX       build-repo.ps1 [<repo-dir>]
.DESCRIPTION  builds the current/given Git repository 
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($RepoDir = "$PWD")

try {
	if (test-path "$Repodir/CMakeLists.txt") { 
		"Building $RepoDir using CMakeLists.txt..."
		& mkdir CMakeBuild
		set-location CMakeBuild

		& cmake ..
		if ($lastExitCode -ne "0") { throw "Executing 'cmake ..' has failed" }

		& make -j4
		if ($lastExitCode -ne "0") { throw "Executing 'make -j4' has failed" }
	} elseif (test-path "$RepoDir/Makefile") {
		"Building $RepoDir using Makefile..."

		& make -j4
		if ($lastExitCode -ne "0") { throw "Executing 'make -j4' has failed" }
	} else {
		write-warning "Sorry, no clue how to build $RepoDir"
		exit 0
	}
	write-host -foregroundColor green "OK - built Git repository $RepoDir"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
