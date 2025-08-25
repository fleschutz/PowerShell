<#
.SYNOPSIS
	Launches the Thunderbird app
.DESCRIPTION
	This script launches the Mozilla Thunderbird email application.
.EXAMPLE
	PS> ./open-thunderbird.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

function TryToExec { param($Folder, $Binary)
        if (test-path "$Folder/$Binary" -pathType leaf) {
                start-process "$Folder/$Binary" -WorkingDirectory "$Folder"
                exit 0 # success
        }
}

try {
	TryToExec "C:\Program Files (x86)\Mozilla Thunderbird" "thunderbird.exe"
	throw "It seems Thunderbird isn't installed yet."
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
}
