<#
.SYNTAX       build-repo.ps1 [<repo-dir>]
.DESCRIPTION  builds a Git repository (supporting cmake,configure,autogen,Imakefile,Makefile)
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($RepoDir = "$PWD")

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	$RepoDirName = (get-item "$RepoDir").Name

	if (test-path "$RepoDir/CMakeLists.txt") { 
		"⏳ Building 📂$RepoDirName using CMakeLists.txt ..."
		if (-not(test-path "$RepoDir/BuildFiles/" -pathType container)) { 
			& mkdir "$RepoDir/BuildFiles/"
		}

		set-location "$RepoDir/BuildFiles/"
		& cmake ..
		if ($lastExitCode -ne "0") { throw "Executing 'cmake ..' has failed" }

		& make -j4
		if ($lastExitCode -ne "0") { throw "Executing 'make -j4' has failed" }

		set-location ..

	} elseif (test-path "$RepoDirName/configure") { 
		"⏳ Building 📂$RepoDirName using 'configure' ..."
		set-location "$RepoDir/"

		& ./configure
		if ($lastExitCode -ne "0") { throw "Executing 'configure' has failed" }

		& make -j4
		if ($lastExitCode -ne "0") { throw "Executing 'make -j4' has failed" }

	} elseif (test-path "$RepoDir/autogen.sh") { 
		"⏳ Building 📂$RepoDirName using 'autogen.sh' ..."
		set-location "$RepoDir/"

		& ./autogen.sh
		if ($lastExitCode -ne "0") { throw "Script 'autogen.sh' has failed" }

		& make -j4
		if ($lastExitCode -ne "0") { throw "Executing 'make -j4' has failed" }

	} elseif (test-path "$RepoDir/Imakefile") {
		"⏳ Building 📂$RepoDirName using Imakefile ..."
		set-location "$RepoDir/"

		& xmkmf 
		if ($lastExitCode -ne "0") { throw "Executing 'xmkmf' has failed" }

		& make -j4
		if ($lastExitCode -ne "0") { throw "Executing 'make -j4' has failed" }

	} elseif (test-path "$RepoDir/Makefile") {
		"⏳ Building 📂$RepoDirName using Makefile..."
		set-location "$RepoDir/"

		& make -j4
		if ($lastExitCode -ne "0") { throw "Executing 'make -j4' has failed" }

	} elseif (test-path "$RepoDir/attower/src/build/DevBuild/build.bat") {
		"⏳ Building 📂$RepoDirName using build.bat ..."
		set-location "$RepoDir/attower/src/build/DevBuild/"

		& ./build.bat build-all-release
		if ($lastExitCode -ne "0") { throw "Script 'build.bat' returned error(s)" }

	} else {
		write-warning "Sorry, no rule found to build 📂$RepoDirName"
		exit 0
	}

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ built Git repository 📂$RepoDirName in $Elapsed sec."
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
