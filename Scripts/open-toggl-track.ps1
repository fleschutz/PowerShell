<#
.SYNOPSIS
	Opens Toggl Track
.DESCRIPTION
	This script starts the Web browser and opens Toggl Track
.EXAMPLE
	PS> ./open-toggl-track
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	& "$PSScriptRoot/open-browser.ps1" "https://track.toggl.com"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
