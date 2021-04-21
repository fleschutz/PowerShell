#!/usr/bin/pwsh
<#
.SYNTAX       build-repo.ps1 [<repo-dir>]
.DESCRIPTION  builds a Git repository (supporting cmake,configure,autogen,Imakefile,Makefile)
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($RepoDir = "$PWD")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	$RepoDir = resolve-path -path "$RepoDir" -relative
	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }

	if (test-path "$RepoDir/CMakeLists.txt") { 
		"⏳ Building 📂$RepoDir using CMakeLists.txt ..."
		if (-not(test-path "$RepoDir/CMakeBuild")) { 
			& mkdir "$RepoDir/CMakeBuild/"
		}
		set-location "$RepoDir/CMakeBuild/"

		& cmake ..
		if ($lastExitCode -ne "0") { throw "Executing 'cmake ..' has failed" }

		& make -j4
		if ($lastExitCode -ne "0") { throw "Executing 'make -j4' has failed" }

	} elseif (test-path "$RepoDir/configure") { 
		"⏳ Building 📂$RepoDir using 'configure' ..."
		set-location "$RepoDir/"

		& ./configure
		if ($lastExitCode -ne "0") { throw "Executing 'configure' has failed" }

		& make -j4
		if ($lastExitCode -ne "0") { throw "Executing 'make -j4' has failed" }

	} elseif (test-path "$RepoDir/autogen.sh") { 
		"⏳ Building 📂$RepoDir using 'autogen.sh' ..."
		set-location "$RepoDir/"

		& ./autogen.sh
		if ($lastExitCode -ne "0") { throw "Script 'autogen.sh' has failed" }

		& make -j4
		if ($lastExitCode -ne "0") { throw "Executing 'make -j4' has failed" }

	} elseif (test-path "$RepoDir/Imakefile") {
		"⏳ Building 📂$RepoDir using Imakefile ..."
		set-location "$RepoDir/"

		& xmkmf 
		if ($lastExitCode -ne "0") { throw "Executing 'xmkmf' has failed" }

		& make -j4
		if ($lastExitCode -ne "0") { throw "Executing 'make -j4' has failed" }

	} elseif (test-path "$RepoDir/Makefile") {
		"⏳ Building 📂$RepoDir using Makefile..."
		set-location "$RepoDir/"

		& make -j4
		if ($lastExitCode -ne "0") { throw "Executing 'make -j4' has failed" }

	} elseif (test-path "$RepoDir/attower/src/build/DevBuild/build.bat") {
		"⏳ Building 📂$RepoDir using build.bat ..."
		set-location "$RepoDir/attower/src/build/DevBuild/"

		& ./build.bat build-all-release
		if ($lastExitCode -ne "0") { throw "Script 'build.bat' returned error(s)" }

	} else {
		write-warning "Sorry, no rule found to build 📂$RepoDir"
		exit 0
	}

	"✔️ built Git repository 📂$RepoDir in $($StopWatch.Elapsed.Seconds) second(s)"
	exit 0
} catch {
	write-error "ERROR: line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
