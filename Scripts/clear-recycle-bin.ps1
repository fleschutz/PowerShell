<#
.SYNOPSIS
	Clears the recycle bin folder
.DESCRIPTION
	This script removes the content of the recycle bin folder permanently.
	NOTE: this cannot be undo!
.EXAMPLE
	PS> ./clear-recycle-bin
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	Clear-RecycleBin -Confirm:$false
	if ($lastExitCode -ne "0") { throw "'Clear-RecycleBin' failed" }

	& "$PSScriptRoot/give-reply.ps1" "It's clean now."
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
