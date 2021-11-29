<#
.SYNOPSIS
	Launches the Git Extensions app
.DESCRIPTION
	This script launches the Git Extensions application.
.EXAMPLE
	PS> ./open-git-extensions
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

function TryExec { param($Folder, $Binary)
	if (test-path "$Folder/$Binary" -pathType leaf) {
		start-process "$Folder/$Binary" -WorkingDirectory "$Folder"
		exit 0 # success
	}
}

try {
	TryExec "C:\Program Files (x86)\GitExtensions" "GitExtensions.exe"
	TryExec "C:\Program Files\GitExtensions" "GitExtensions.exe"
	& "$PSScriptRoot/speak-english.ps1" "Sorry, I can't find Git Extensions"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
