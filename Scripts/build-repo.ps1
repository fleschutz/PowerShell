<#
.SYNOPSIS
	Builds a repository 
.DESCRIPTION
	This PowerShell script builds a repository by supporting: cmake, configure, autogen, Imakefile, and Makefile.
.PARAMETER RepoDir
	Specifies the path to the Git repository
.EXAMPLE
	PS> ./build-repo C:\MyRepo
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$RepoDir = "$PWD")

function BuildInDir { param($Path)
	$DirName = (Get-Item "$Path").Name
	if (Test-Path "$Path/CMakeLists.txt" -pathType leaf) {
		"⏳ Building repo 📂$DirName using CMakeLists.txt into subfolder _My_Build ..."
		if (-not(Test-Path "$Path/_My_Build/" -pathType container)) { 
			& mkdir "$Path/_My_Build/"
		}
		Set-Location "$Path/_My_Build/"

		& cmake ..
		if ($lastExitCode -ne "0") { throw "Executing 'cmake ..' has failed" }

		& make -j4
		if ($lastExitCode -ne "0") { throw "Executing 'make -j4' has failed" }

		& make test
		if ($lastExitCode -ne "0") { throw "Executing 'make test' has failed" }

	} elseif (Test-Path "$Path/configure" -pathType leaf) { 
		"⏳ Building repo 📂$DirName using 'configure'..."
		Set-Location "$Path/"

		& ./configure
		#if ($lastExitCode -ne "0") { throw "Script 'configure' exited with error code $lastExitCode" }

		& make -j4
		if ($lastExitCode -ne "0") { throw "Executing 'make -j4' has failed" }

		& make test
		if ($lastExitCode -ne "0") { throw "Executing 'make test' has failed" }

	} elseif (Test-Path "$Path/autogen.sh" -pathType leaf) { 
		"⏳ Building repo 📂$DirName using 'autogen.sh'..."
		Set-Location "$Path/"

		& ./autogen.sh
		if ($lastExitCode -ne "0") { throw "Script 'autogen.sh' exited with error code $lastExitCode" }

		& make -j4
		if ($lastExitCode -ne "0") { throw "Executing 'make -j4' has failed" }

	} elseif (Test-Path "$Path/build.gradle" -pathType leaf) {
		"⏳ Building repo 📂$DirName using build.gradle..."
		Set-Location "$Path"

		& gradle build
		if ($lastExitCode -ne "0") { throw "'gradle build' has failed" }

		& gradle test
		if ($lastExitCode -ne "0") { throw "'gradle test' has failed" }

	} elseif (Test-Path "$Path/Imakefile" -pathType leaf) {
		"⏳ Building repo 📂$DirName using Imakefile..."
		Set-Location "$RepoDir/"

		& xmkmf 
		if ($lastExitCode -ne "0") { throw "Executing 'xmkmf' has failed" }

		& make -j4
		if ($lastExitCode -ne "0") { throw "Executing 'make -j4' has failed" }

	} elseif (Test-Path "$Path/Makefile" -pathType leaf) {
		"⏳ Building repo 📂$DirName using Makefile..."
		Set-Location "$Path"

		& make -j4
		if ($lastExitCode -ne "0") { throw "Executing 'make -j4' has failed" }

	} elseif (Test-Path "$Path/makefile" -pathType leaf) {
		"⏳ Building repo 📂$DirName using makefile..."
		Set-Location "$Path"

		& make -j4
		if ($lastExitCode -ne "0") { throw "Executing 'make -j4' has failed" }

	} elseif (Test-Path "$Path/compile.sh" -pathType leaf) { 
		"⏳ Building repo 📂$DirName using 'compile.sh'..."
		Set-Location "$Path/"

		& ./compile.sh
		if ($lastExitCode -ne "0") { throw "Script 'compile.sh' exited with error code $lastExitCode" }

		& make -j4
		if ($lastExitCode -ne "0") { throw "Executing 'make -j4' has failed" }

	} elseif (Test-Path "$Path/attower/src/build/DevBuild/build.bat" -pathType leaf) {
		"⏳ Building repo 📂$DirName using build.bat ..."
		Set-Location "$Path/attower/src/build/DevBuild/"

		& ./build.bat build-all-release
		if ($lastExitCode -ne "0") { throw "Script 'build.bat' exited with error code $lastExitCode" }

	} elseif (Test-Path "$Path/$DirName" -pathType container) {
		"⏳ No make rule found, trying subfolder 📂$($DirName)..."
		BuildInDir "$Path/$DirName"
	} else {
		Write-Warning "Sorry, no make rule applies to: 📂$DirName"
		exit 0 # success
	}
}

try {
	$StopWatch = [system.diagnostics.stopwatch]::startNew()

	if (-not(Test-Path "$RepoDir" -pathType container)) { throw "Can't access directory: $RepoDir" }
	$RepoDirName = (Get-Item "$RepoDir").Name

	$PreviousPath = Get-Location
	BuildInDir "$RepoDir"
	Set-Location "$PreviousPath"

	[int]$Elapsed = $StopWatch.Elapsed.TotalSeconds
	"✔️ built repo 📂$RepoDirName in $Elapsed sec"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
