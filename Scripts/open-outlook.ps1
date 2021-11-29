<#
.SYNOPSIS
	Launches the Microsoft Outlook app
.DESCRIPTION
	This script launches the Microsoft Outlook email application.
.EXAMPLE
	PS> ./open-outlook
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
	TryLaunching "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE"
	TryLaunching "C:\Programs\Microsoft Office\Office14\OUTLOOK.EXE"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
