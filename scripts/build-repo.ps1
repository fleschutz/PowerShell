<#
.SYNOPSIS
	Builds a repo
.DESCRIPTION
	This PowerShell script builds an arbitrary source code repository by supporting
	build systems like: autogen, cargo, cmake, configure, Gradle, Imakefile, Makefile,
	Meson, and PowerShell (build.ps1).
.PARAMETER path
	Specifies the file path to the Git repository (default: current working directory)
.EXAMPLE
	PS> ./build-repo.ps1 C:\Repos\ninja
	⏳ Configuring CMake by executing 'cmake .'...
	...
	✅ Repo 'ninja' built successfully in 47s, results at: 📂C:\Repos\ninja\_x86_64_build
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "$PWD")

function BuildFolder([string]$path) {
	$dirName = (Get-Item "$path").Name
	if (Test-Path "$path/CMakeLists.txt" -pathType leaf) {
		"⏳ (1/3) Configuring CMake by executing 'cmake .'..."
		$arch = (uname -m)
		$global:results = "$path/_$(arch)_build/"
		if (-not(Test-Path $global:results -pathType container)) { 
			& mkdir $global:results
		}
		Set-Location $global:results
		& cmake ..
		if ($lastExitCode -ne 0) { throw "Executing 'cmake ..' failed with exit code $lastExitCode" }

		"⏳ (2/3) Building $dirName by executing 'make -j4'..."
		& make -j4
		if ($lastExitCode -ne 0) { throw "Executing 'make -j4' failed with exit code $lastExitCode" }

		"⏳ (3/3) Testing $dirName by executing 'ctest -V'... (if tests are provided)"
		& ctest -V
		if ($lastExitCode -ne 0) { throw "Executing 'ctest -V' failed with exit code $lastExitCode" }
	} elseif (Test-Path "$path/.cargo/release.toml" -pathType leaf) { 

		"⏳ Building '$dirName' by executing 'cargo build'..."
		Set-Location "$path/"
		& cargo build --config .cargo/release.toml --release
		if ($lastExitCode -ne 0) { throw "Executing 'cargo build' failed with exit code $lastExitCode" }

	} elseif (Test-Path "$path/autogen.sh" -pathType leaf) { 

		"⏳ (1/3) Building '$dirName' by executing 'autogen.sh'..."
		Set-Location "$path/"
		& ./autogen.sh --force
		if ($lastExitCode -ne 0) { throw "Executing './autogen.sh --force' failed with exit code $lastExitCode" }
		"⏳ (2/3) Executing './configure'..."
		& ./configure
		if ($lastExitCode -ne 0) { throw "Executing './configure' failed with exit code $lastExitCode" }

		"⏳ (3/3) Executing 'make -j4' to compile and link..."
		& make -j4
		if ($lastExitCode -ne 0) { throw "Executing 'make -j4' failed with exit code $lastExitCode" }

	} elseif (Test-Path "$path/configure" -pathType leaf) { 

		"⏳ (1/3) Building '$dirName' by executing './configure'..."
		Set-Location "$path/"
		& ./configure
		#if ($lastExitCode -ne 0) { throw "Executing './configure' exited with error code $lastExitCode" }

		"⏳ (2/3) Compiling and linking '$dirName' by executing 'make -j4'..."
		& make -j4
		if ($lastExitCode -ne 0) { throw "Executing 'make -j4' failed with exit code $lastExitCode" }

		"⏳ (3/3) Checking '$dirName' by executing 'make test'..."
		& make test
		if ($lastExitCode -ne 0) { throw "Executing 'make test' failed with exit code $lastExitCode" }

	} elseif (Test-Path "$path/build.gradle" -pathType leaf) {

		"⏳ (1/2) Building '$dirName' by executing 'gradle build'..."
		Set-Location "$path"
		& gradle build
		if ($lastExitCode -ne 0) { throw "Executing 'gradle build' failed with exit code $lastExitCode" }

		"⏳ (2/2) Checking '$dirName' by executing 'gradle test'..."
		& gradle test
		if ($lastExitCode -ne 0) { throw "Executing 'gradle test' failed with exit code $lastExitCode" }

	} elseif (Test-Path "$path/meson.build" -pathType leaf) {
		"⏳ Building '$dirName' by using Meson..."
		Set-Location "$path"
		& meson . build --prefix=/usr/local
		if ($lastExitCode -ne 0) { throw "Executing 'meson . build' failed with exit code $lastExitCode" }

	} elseif (Test-Path "$path/Imakefile" -pathType leaf) {
		"⏳ Building '$dirName' by using Imakefile..."
		Set-Location "$path/"
		& xmkmf 
		if ($lastExitCode -ne 0) { throw "Executing 'xmkmf' failed with exit code $lastExitCode" }

		"⏳ Executing 'make -j4' to compile and link..."
		& make -j4
		if ($lastExitCode -ne 0) { throw "Executing 'make -j4' failed with exit code $lastExitCode" }

	} elseif (Test-Path "$path/Makefile" -pathType leaf) {

		"⏳ Building '$dirName' by using Makefile..."
		Set-Location "$path"
		& make -j4
		if ($lastExitCode -ne 0) { throw "Executing 'make -j4' failed with exit code $lastExitCode" }

	} elseif (Test-Path "$path/makefile" -pathType leaf) {
		"⏳ Building '$dirName' by using makefile..."
		Set-Location "$path"

		& make -j4
		if ($lastExitCode -ne 0) { throw "Executing 'make -j4' failed with exit code $lastExitCode" }

	} elseif (Test-Path "$path/build.ps1" -pathType leaf) { 

		"⏳ Building '$dirName' by executing 'build.ps1'..."
		Set-Location "$path/"
		& ./build.ps1
		if ($lastExitCode -ne 0) { throw "Executing './build.ps1' failed with exit code $lastExitCode" }

	} elseif (Test-Path "$path/compile.sh" -pathType leaf) { 

		"⏳ Building '$dirName' by executing 'compile.sh'..."
		Set-Location "$path/"
		& ./compile.sh
		if ($lastExitCode -ne 0) { throw "Executing './compile.sh' failed with exit code $lastExitCode" }

		"⏳ Executing 'make -j4' to compile and link..."
		& make -j4
		if ($lastExitCode -ne 0) { throw "Executing 'make -j4' failed with exit code $lastExitCode" }

	} elseif (Test-Path "$path/attower/src/build/DevBuild/build.bat" -pathType leaf) {

		Write-Host "⏳ Building '$dirName' by executing 'build.bat'..."
		Set-Location "$path/attower/src/build/DevBuild/"
		& ./build.bat build-core-release
		if ($lastExitCode -ne 0) { throw "Executing 'build.bat' failed with exit code $lastExitCode" }
		$global:results = "$path\attower\Executables"

	} elseif (Test-Path "$path/$dirName" -pathType container) {
		"⏳ No make rule found, trying subfolder '$($dirName)'..."
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

	$dirName = (Get-Item "$path").Name
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	if ($global:results -eq "") {
		"✅ Repo '$dirName' built successfully in $($elapsed)s."
	} else {
		"✅ Repo '$dirName' built successfully in $($elapsed)s, results at: 📂$($global:results)"
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	Set-Location "$previousPath"
	exit 1
}
