<#
.SYNOPSIS
	Removes the content of the recycle bin folder permanently
.DESCRIPTION
	This script removes the content of the recycle bin folder permanently.
	NOTE: can not be undo!
.EXAMPLE
	PS> ./clear-recycle-bin
	✔️ cleared recycle bin
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	Clear-RecycleBin -Confirm:$false
	if ($lastExitCode -ne "0") { throw "'Clear-RecycleBin' failed" }

	"✔️ cleared recycle bin"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
