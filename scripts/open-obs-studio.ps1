<#
.SYNOPSIS
	Launches OBS Studio
.DESCRIPTION
	This script launches the OBS Studio application.
.EXAMPLE
	PS> ./open-obs-studio
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

function TryLaunching { param([string]$Path, [string]$Dir)
	if (test-path "$Path" -pathType leaf) {
		start-process -FilePath "$Path" -WorkingDirectory "$Dir"
		exit 0 # success
	}
}

try {
	TryLaunching "C:\Program Files (x86)\OBS Studio\bin\64bit\obs64.exe" "C:\Program Files (x86)\OBS Studio\bin\64bit\"
	TryLaunching "C:\Program Files\OBS Studio\bin\64bit\obs64.exe" "C:\Program Files\OBS Studio\bin\64bit\"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
