<#
.SYNOPSIS
	Launches the Thunderbird app
.DESCRIPTION
	This script launches the Mozilla Thunderbird email application.
.EXAMPLE
	PS> ./open-thunderbird
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

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
	& "$PSScriptRoot/give-reply.ps1" "Sorry: $($Error[0])"
}
