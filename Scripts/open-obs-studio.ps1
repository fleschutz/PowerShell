<#
.SYNOPSIS
	Launches OBS Studio
.DESCRIPTION
	This script launches the OBS Studio application.
.EXAMPLE
	PS> ./open-obs-studio
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
	TryLaunching "C:\Program Files (x86)\OBS Studio\bin\64bit\obs64.exe"
	TryLaunching "C:\Program Files\OBS Studio\bin\64bit\obs64.exe"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
