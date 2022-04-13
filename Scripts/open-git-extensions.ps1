<#
.SYNOPSIS
	Launches Git Extensions 
.DESCRIPTION
	This PowerShell script launches the Git Extensions application.
.EXAMPLE
	PS> ./open-git-extensions
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

function TryToExec { param($Folder, $Binary)
	if (test-path "$Folder/$Binary" -pathType leaf) {
		start-process "$Folder/$Binary" -WorkingDirectory "$Folder"
		exit 0 # success
	}
}

try {
	TryToExec "C:\Program Files (x86)\GitExtensions" "GitExtensions.exe"
	TryToExec "C:\Program Files\GitExtensions" "GitExtensions.exe"
	& "$PSScriptRoot/give-reply.ps1" "Sorry, can't find Git Extensions."
	exit 1
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
