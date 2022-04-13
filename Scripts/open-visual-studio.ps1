<#
.SYNOPSIS
	Launches the Visual Studio app
.DESCRIPTION
	This script launches the Microsoft Visual Studio application.
.EXAMPLE
	PS> ./open-visual-studio
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

function TryLaunching { param($Path)
	if (test-path "$Path" -pathType leaf) {
		start-process "$Path"
		exit 0 # success
	}
}

try {
	TryLaunching "C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\Common7\IDE\devenv.exe"
	TryLaunching "C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE\devenv.exe"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
