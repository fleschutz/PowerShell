<#
.SYNOPSIS
	Builds a Git repository 
.DESCRIPTION
	This scripts supports building with cmake, configure, autogen, Imakefile and Makefile.
.PARAMETER RepoDir
	Specifies the path to the Git repository
.EXAMPLE
	PS> ./build-repo C:\MyRepo
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

param([string]$RepoDir = "$PWD")

function MakeDir { param($Path)
	$DirName = (get-item "$Path").Name
	if (test-path "$Path/CMakeLists.txt" -pathType leaf) {
		"🔨 Building 📂$DirName using CMakeLists.txt to subfolder BuildFiles..."
		if (-not(test-path "$Path/BuildFiles/" -pathType container)) { 
			& mkdir "$Path/BuildFiles/"
		}
		set-location "$Path/BuildFiles/"

		& cmake ..
		if ($lastExitCode -ne "0") { throw "Executing 'cmake ..' has failed" }

		& make -j4
		if ($lastExitCode -ne "0") { throw "Executing 'make -j4' has failed" }

		& make test
		if ($lastExitCode -ne "0") { throw "Executing 'make test' has failed" }

	} elseif (test-path "$Path/configure" -pathType leaf) { 
		"🔨 Building 📂$DirName using 'configure'..."
		set-location "$Path/"

		& ./configure
		#if ($lastExitCode -ne "0") { throw "Script 'configure' exited with error code $lastExitCode" }

		& make -j4
		if ($lastExitCode -ne "0") { throw "Executing 'make -j4' has failed" }

		& make test
		if ($lastExitCode -ne "0") { throw "Executing 'make test' has failed" }

	} elseif (test-path "$Path/autogen.sh" -pathType leaf) { 
		"🔨 Building 📂$DirName using 'autogen.sh'..."
		set-location "$Path/"

		& ./autogen.sh
		if ($lastExitCode -ne "0") { throw "Script 'autogen.sh' exited with error code $lastExitCode" }

		& make -j4
		if ($lastExitCode -ne "0") { throw "Executing 'make -j4' has failed" }

	} elseif (test-path "$Path/build.gradle" -pathType leaf) {
		"🔨 Building 📂$DirName using build.gradle..."
		set-location "$Path"

		& gradle build
		if ($lastExitCode -ne "0") { throw "'gradle build' has failed" }

		& gradle test
		if ($lastExitCode -ne "0") { throw "'gradle test' has failed" }

	} elseif (test-path "$Path/Imakefile" -pathType leaf) {
		"🔨 Building 📂$DirName using Imakefile..."
		set-location "$RepoDir/"

		& xmkmf 
		if ($lastExitCode -ne "0") { throw "Executing 'xmkmf' has failed" }

		& make -j4
		if ($lastExitCode -ne "0") { throw "Executing 'make -j4' has failed" }

	} elseif (test-path "$Path/Makefile" -pathType leaf) {
		"🔨 Building 📂$DirName using Makefile..."
		set-location "$Path"

		& make -j4
		if ($lastExitCode -ne "0") { throw "Executing 'make -j4' has failed" }

	} elseif (test-path "$Path/compile.sh" -pathType leaf) { 
		"🔨 Building 📂$DirName using 'compile.sh'..."
		set-location "$Path/"

		& ./compile.sh
		if ($lastExitCode -ne "0") { throw "Script 'compile.sh' exited with error code $lastExitCode" }

		& make -j4
		if ($lastExitCode -ne "0") { throw "Executing 'make -j4' has failed" }

	} elseif (test-path "$Path/attower/src/build/DevBuild/build.bat" -pathType leaf) {
		"🔨 Building 📂$DirName using build.bat ..."
		set-location "$Path/attower/src/build/DevBuild/"

		& ./build.bat build-all-release
		if ($lastExitCode -ne "0") { throw "Script 'build.bat' exited with error code $lastExitCode" }

	} elseif (test-path "$Path/$DirName" -pathType container) {
		"🔨 No make rule found, trying subfolder 📂$($DirName)..."
		MakeDir "$Path/$DirName"
	} else {
		write-warning "Sorry, no make rule applies to: 📂$DirName"
		exit 0 # success
	}
}

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	if (-not(test-path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	$RepoDirName = (get-item "$RepoDir").Name

	$PreviousPath = get-location
	MakeDir "$RepoDir"
	set-location "$PreviousPath"

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ built Git repository 📂$RepoDirName in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
