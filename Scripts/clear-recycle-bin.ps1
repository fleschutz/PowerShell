<#
.SYNOPSIS
	clear-recycle-bin.ps1 
.DESCRIPTION
	Removes the content of the recycle bin folder.
	NOTE: can not be undo!
.EXAMPLE
	PS> .\clear-recycle-bin.ps1 
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	Clear-RecycleBin -Confirm:$false
	if ($lastExitCode -ne "0") { throw "'Clear-RecycleBin' failed" }

	"✔️ cleared recycle bin"
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
