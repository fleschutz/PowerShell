<#
.SYNOPSIS
	Opens the user's recycle bin folder
.DESCRIPTION
	This script starts the File Explorer and shows the user's recycle bin folder.
.EXAMPLE
	PS> ./open-recycle-bin
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	start shell:recyclebinfolder
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
