<#
.SYNOPSIS
	Launches Git Extensions
.DESCRIPTION
	This script launches the Git Extensions application.
.EXAMPLE
	PS> ./open-git-extensions
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
	TryLaunching "C:\Program Files (x86)\GitExtensions\GitExtensions.exe"
	TryLaunching "C:\Program Files\GitExtensions\GitExtensions.exe"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
