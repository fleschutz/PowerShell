<#
.SYNOPSIS
	Builds a repo
.DESCRIPTION
	This PowerShell script builds a Git repository by supporting the build systems: autogen, cmake, configure, Gradle, Imakefile, Makefile, and Meson.
.PARAMETER path
	Specifies the path to the Git repository (current working directory by default)
.EXAMPLE
	PS> ./build-repo.ps1 C:\Repos\ninja
	⏳ Building 📂ninja by using CMake...
	...
	✅ Build of 📂ninja succeeded in 47s, results in: 📂C:\Repos\ninja\_results
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "$PWD")

function BuildFolder([string]$path) {
	$dirName = (Get-Item "$path").Name
	if (Test-Path "$path/CMakeLists.txt" -pathType leaf) {
		"⏳ (1/4) Building 📂$dirName by using CMake..."
		$global:results = "$path/_results/"
		if (-not(Test-Path $global:results -pathType container)) { 
			& mkdir $global:results
		}
		Set-Location $global:results

		"⏳ (2/4) Executing 'cmake' to generate the Makefile..."
		& cmake ..
		if ($lastExitCode -ne 0) { throw "Executing 'cmake ..' failed with exit code $lastExitCode" }

		"⏳ (3/4) Executing 'make -j4' to compile and link..."
		& make -j4
		if ($lastExitCode -ne 0) { throw "Executing 'make -j4' failed with exit code $lastExitCode" }

		"⏳ (4/4) Executing 'ctest -V'... (if tests are provided)"
		& ctest -V
		if ($lastExitCode -ne 0) { throw "Executing 'ctest -V' failed with exit code $lastExitCode" }
	} elseif (Test-Path "$path/autogen.sh" -pathType leaf) { 
		"⏳ Building 📂$dirName by executing 'autogen.sh'..."
		Set-Location "$path/"
		& ./autogen.sh --force
		if ($lastExitCode -ne 0) { throw "Executing './autogen.sh --force' failed with exit code $lastExitCode" }
		"⏳ Executing './configure'..."

		& ./configure
		if ($lastExitCode -ne 0) { throw "Executing './configure' failed with exit code $lastExitCode" }

		& make -j4
		if ($lastExitCode -ne 0) { throw "Executing 'make -j4' failed with exit code $lastExitCode" }

	} elseif (Test-Path "$path/configure" -pathType leaf) { 
		"⏳ Building 📂$dirName by executing './configure' and 'make'..."
		Set-Location "$path/"

		& ./configure
		#if ($lastExitCode -ne 0) { throw "Executing './configure' exited with error code $lastExitCode" }

		& make -j4
		if ($lastExitCode -ne 0) { throw "Executing 'make -j4' failed with exit code $lastExitCode" }

		& make test
		if ($lastExitCode -ne 0) { throw "Executing 'make test' failed with exit code $lastExitCode" }

	} elseif (Test-Path "$path/build.gradle" -pathType leaf) {
		"⏳ Building 📂$dirName by using Gradle..."
		Set-Location "$path"

		& gradle build
		if ($lastExitCode -ne 0) { throw "Executing 'gradle build' failed with exit code $lastExitCode" }

		& gradle test
		if ($lastExitCode -ne 0) { throw "Executing 'gradle test' failed with exit code $lastExitCode" }

	} elseif (Test-Path "$path/meson.build" -pathType leaf) {
		"⏳ Building 📂$dirName by using Meson..."
		Set-Location "$path"
		& meson . build --prefix=/usr/local
		if ($lastExitCode -ne 0) { throw "Executing 'meson . build' failed with exit code $lastExitCode" }

	} elseif (Test-Path "$path/Imakefile" -pathType leaf) {
		"⏳ Building 📂$dirName by using Imakefile..."
		Set-Location "$path/"

		& xmkmf 
		if ($lastExitCode -ne 0) { throw "Executing 'xmkmf' failed with exit code $lastExitCode" }

		& make -j4
		if ($lastExitCode -ne 0) { throw "Executing 'make -j4' failed with exit code $lastExitCode" }

	} elseif (Test-Path "$path/Makefile" -pathType leaf) {
		"⏳ Building 📂$dirName by using Makefile..."
		Set-Location "$path"

		& make -j4
		if ($lastExitCode -ne 0) { throw "Executing 'make -j4' failed with exit code $lastExitCode" }

	} elseif (Test-Path "$path/makefile" -pathType leaf) {
		"⏳ Building 📂$dirName by using makefile..."
		Set-Location "$path"

		& make -j4
		if ($lastExitCode -ne 0) { throw "Executing 'make -j4' failed with exit code $lastExitCode" }

	} elseif (Test-Path "$path/compile.sh" -pathType leaf) { 
		"⏳ Building 📂$dirName by executing 'compile.sh'..."
		Set-Location "$path/"

		& ./compile.sh
		if ($lastExitCode -ne 0) { throw "Executing './compile.sh' failed with exit code $lastExitCode" }

		& make -j4
		if ($lastExitCode -ne 0) { throw "Executing 'make -j4' failed with exit code $lastExitCode" }

	} elseif (Test-Path "$path/attower/src/build/DevBuild/build.bat" -pathType leaf) {

		Write-Host "⏳ Building 📂$dirName by executing 'build.bat'..."
		Set-Location "$path/attower/src/build/DevBuild/"
		& ./build.bat build-core-release
		if ($lastExitCode -ne 0) { throw "Executing 'build.bat' failed with exit code $lastExitCode" }
		$global:results = "$path\attower\Executables"

	} elseif (Test-Path "$path/$dirName" -pathType container) {
		"⏳ No make rule found, trying subfolder 📂$($dirName)..."
		BuildFolder "$path/$dirName"
	} else {
		Write-Warning "Sorry, no make rule applies to: 📂$dirName"
		exit 0 # success
	}
}

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()
	$previousPath = Get-Location

	if (-not(Test-Path "$path" -pathType container)) { throw "The file path '$path' doesn't exist (yet)" }

	$global:results = ""
	BuildFolder "$path"
	Set-Location "$previousPath"

	$repoDirName = (Get-Item "$path").Name
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	if ($global:results -eq "") {
		"✅ Build of 📂$repoDirName succeeded in $($elapsed)s."
	} else {
		"✅ Build of 📂$repoDirName succeeded in $($elapsed)s, results in: 📂$($global:results)"
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	Set-Location "$previousPath"
	exit 1
}
