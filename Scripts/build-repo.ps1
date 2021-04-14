#!/usr/bin/pwsh
<#
.SYNTAX       build-repo.ps1 [<repo-dir>]
.DESCRIPTION  builds the current/given Git repository 
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($RepoDir = "$PWD")

try {
	if (test-path CMakeLists.txt) { 
		"Building $RepoDir using CMakeLists.txt..."
		& cmake .
		if ($lastExitCode -ne "0") { throw "Can't execute 'cmake .'" }

		& make
		if ($lastExitCode -ne "0") { throw "Can't execute 'make .'" }
	} elseif (test-path Makefile) {
		"Building $RepoDir using Makefile..."
		& make
		if ($lastExitCode -ne "0") { throw "Can't execute 'make .'" }
	} else {
		write-warning "Sorry, no clue how to build $RepoDir"
	}
	write-host -foregroundColor green "OK - built Git repository $RepoDir"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
