#!/usr/bin/pwsh
<#
.SYNTAX       build-repo.ps1 [<repo-dir>]
.DESCRIPTION  builds the current/given Git repository 
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($RepoDir = "$PWD")

try {
	if (test-path "$RepoDir/CMakeLists.txt") { 
		"Building $RepoDir using CMakeLists.txt..."
		if (-not(test-path "$RepoDir/CMakeBuild") { 
			& mkdir "$RepoDir/CMakeBuild/"
		}
		set-location "$RepoDir/CMakeBuild/"

		& cmake ..
		if ($lastExitCode -ne "0") { throw "Executing 'cmake ..' has failed" }

		& make -j4
		if ($lastExitCode -ne "0") { throw "Executing 'make -j4' has failed" }
	} elseif (test-path "$RepoDir/Makefile") {
		"Building $RepoDir using Makefile..."
		set-location "$RepoDir/"

		& make -j4
		if ($lastExitCode -ne "0") { throw "Executing 'make -j4' has failed" }
	} elseif (test-path "$RepoDir/attower/src/build/DevBuild/build-all-release.bat") {
		"Building $RepoDir using build-all-release.bat..."
		set-location "$RepoDir/attower/src/build/DevBuild/"

		& build-all-release.bat
		if ($lastExitCode -ne "0") { throw "Script 'build-all-release.bat' returned error(s)" }

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
