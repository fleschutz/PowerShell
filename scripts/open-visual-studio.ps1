<#
.SYNOPSIS
	Launches Visual Studio
.DESCRIPTION
	This PowerShell script launches the Microsoft Visual Studio application.
.EXAMPLE
	PS> ./open-visual-studio.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

function tryToLaunch { param($filePath)
	if (Test-Path "$filePath" -pathType leaf) {
		Start-Process "$filePath"
		exit 0 # success
	}
}

try {
	tryToLaunch "C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\Common7\IDE\devenv.exe"
	tryToLaunch "C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE\devenv.exe"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
