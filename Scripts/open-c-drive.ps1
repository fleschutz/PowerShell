<#
.SYNOPSIS
	Opens the C: drive folder
.DESCRIPTION
	This script launches the File Explorer showing the C: drive folder.
.EXAMPLE
	PS> ./open-c-drive
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	& "$PSScriptRoot/open-file-explorer.ps1" C:
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
