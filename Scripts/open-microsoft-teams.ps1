<#
.SYNOPSIS
	Launches the Microsoft Teams app
.DESCRIPTION
	This script launches the Microsoft Teams application.
.EXAMPLE
	PS> ./open-microsoft-teams
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	start-process msteams:
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
