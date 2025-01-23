The *build-repo.ps1* Script
===========================

This PowerShell script builds a Git repository by supporting build systems such as: autogen, cmake, configure, Gradle, Imakefile, Makefile, and Meson.

Parameters
----------
```powershell
/Repos/PowerShell/scripts/build-repo.ps1 [[-path] <String>] [<CommonParameters>]

-path <String>
    Specifies the path to the Git repository (default is current working directory)
    
    Required?                    false
    Position?                    1
    Default value                "$PWD"
    Accept pipeline input?       false
    Accept wildcard characters?  false

[<CommonParameters>]
    This script supports the common parameters: Verbose, Debug, ErrorAction, ErrorVariable, WarningAction, 
    WarningVariable, OutBuffer, PipelineVariable, and OutVariable.
```

Example
-------
```powershell
PS> ./build-repo.ps1 C:\Repos\ninja
⏳ Building 📂ninja using CMakeLists.txt into 📂ninja/_Build_Results...
...
✅ Built 📂ninja repository in 47 sec.

```

Notes
-----
Author: Markus Fleschutz | License: CC0

Related Links
-------------
https://github.com/fleschutz/PowerShell

Script Content
--------------
```powershell
<#
.SYNOPSIS
	Builds a repository 
.DESCRIPTION
	This PowerShell script builds a Git repository by supporting build systems such as: autogen, cmake, configure, Gradle, Imakefile, Makefile, and Meson.
.PARAMETER path
	Specifies the path to the Git repository (default is current working directory)
.EXAMPLE
	PS> ./build-repo.ps1 C:\Repos\ninja
	⏳ Building 📂ninja using CMakeLists.txt into 📂ninja/_Build_Results...
	...
	✅ Built 📂ninja repository in 47 sec.
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$path = "$PWD")

function BuildInDir([string]$path) {
	$dirName = (Get-Item "$path").Name
	if (Test-Path "$path/CMakeLists.txt" -pathType leaf) {
		"⏳ (1/4) Building 📂$dirName by using CMake into 📂$dirName/_Build_Results..."
		if (-not(Test-Path "$path/_Build_Results/" -pathType container)) { 
			& mkdir "$path/_Build_Results/"
		}
		Set-Location "$path/_Build_Results/"

		"⏳ (2/4) Executing 'cmake' to generate the Makefile..."
		& cmake ..
		if ($lastExitCode -ne "0") { throw "Executing 'cmake ..' exited with error code $lastExitCode" }

		"⏳ (3/4) Executing 'make -j4' to compile and link..."
		& make -j4
		if ($lastExitCode -ne "0") { throw "Executing 'make -j4' exited with error code $lastExitCode" }

		"⏳ (4/4) Executing 'ctest -V' to perform tests (optional)..."
		& ctest -V
		if ($lastExitCode -ne "0") { throw "Executing 'ctest -V' exited with error code $lastExitCode" }

	} elseif (Test-Path "$path/autogen.sh" -pathType leaf) { 
		"⏳ Building 📂$dirName by using 'autogen.sh'..."
		Set-Location "$path/"

		& ./autogen.sh --force
		if ($lastExitCode -ne "0") { throw "Executing './autogen.sh --force' exited with error code $lastExitCode" }

		& ./configure
		if ($lastExitCode -ne "0") { throw "Executing './configure' exited with error code $lastExitCode" }

		& make -j4
		if ($lastExitCode -ne "0") { throw "Executing 'make -j4' exited with error code $lastExitCode" }


	} elseif (Test-Path "$path/configure" -pathType leaf) { 
		"⏳ Building 📂$dirName by using 'configure'..."
		Set-Location "$path/"

		& ./configure
		#if ($lastExitCode -ne "0") { throw "Executing './configure' exited with error code $lastExitCode" }

		& make -j4
		if ($lastExitCode -ne "0") { throw "Executing 'make -j4' has failed" }

		& make test
		if ($lastExitCode -ne "0") { throw "Executing 'make test' has failed" }

	} elseif (Test-Path "$path/build.gradle" -pathType leaf) {
		"⏳ Building 📂$dirName by using Gradle..."
		Set-Location "$path"

		& gradle build
		if ($lastExitCode -ne "0") { throw "Executing 'gradle build' exited with error code $lastExitCode" }

		& gradle test
		if ($lastExitCode -ne "0") { throw "Executing 'gradle test' exited with error code $lastExitCode" }

	} elseif (Test-Path "$path/meson.build" -pathType leaf) {
		"⏳ Building 📂$dirName by using Meson..."
		Set-Location "$path"
		& meson . build --prefix=/usr/local
		if ($lastExitCode -ne "0") { throw "Executing 'meson . build' exited with error code $lastExitCode" }

	} elseif (Test-Path "$path/Imakefile" -pathType leaf) {
		"⏳ Building 📂$dirName by using Imakefile..."
		Set-Location "$path/"

		& xmkmf 
		if ($lastExitCode -ne "0") { throw "Executing 'xmkmf' has failed" }

		& make -j4
		if ($lastExitCode -ne "0") { throw "Executing 'make -j4' has failed" }

	} elseif (Test-Path "$path/Makefile" -pathType leaf) {
		"⏳ Building 📂$dirName by using Makefile..."
		Set-Location "$path"

		& make -j4
		if ($lastExitCode -ne "0") { throw "Executing 'make -j4' has failed" }

	} elseif (Test-Path "$path/makefile" -pathType leaf) {
		"⏳ Building 📂$dirName by using makefile..."
		Set-Location "$path"

		& make -j4
		if ($lastExitCode -ne "0") { throw "Executing 'make -j4' has failed" }

	} elseif (Test-Path "$path/compile.sh" -pathType leaf) { 
		"⏳ Building 📂$dirName by using 'compile.sh'..."
		Set-Location "$path/"

		& ./compile.sh
		if ($lastExitCode -ne "0") { throw "Executing './compile.sh' exited with error code $lastExitCode" }

		& make -j4
		if ($lastExitCode -ne "0") { throw "Executing 'make -j4' has failed" }

	} elseif (Test-Path "$path/attower/src/build/DevBuild/build.bat" -pathType leaf) {
		"⏳ Building 📂$dirName by using build.bat ..."
		Set-Location "$path/attower/src/build/DevBuild/"

		& ./build.bat build-all-release
		if ($lastExitCode -ne "0") { throw "Executing 'build.bat build-all-release' exited with error code $lastExitCode" }

	} elseif (Test-Path "$path/$dirName" -pathType container) {
		"⏳ No make rule found, trying subfolder 📂$($dirName)..."
		BuildInDir "$path/$dirName"
	} else {
		Write-Warning "Sorry, no make rule applies to: 📂$dirName"
		exit 0 # success
	}
}

try {
	$stopWatch = [system.diagnostics.stopwatch]::startNew()

	if (-not(Test-Path "$path" -pathType container)) { throw "Can't access directory: $path" }

	$previousPath = Get-Location
	BuildInDir "$path"
	Set-Location "$previousPath"

	$repoDirName = (Get-Item "$path").Name
	[int]$elapsed = $stopWatch.Elapsed.TotalSeconds
	"✅ Built 📂$repoDirName repository in $elapsed sec."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
```

*(page generated by convert-ps2md.ps1 as of 01/23/2025 12:15:19)*
