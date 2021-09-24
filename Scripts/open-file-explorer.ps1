<#
.SYNOPSIS
	open-file-explorer.ps1
.DESCRIPTION
	Starts the File Explorer
.EXAMPLE
	PS> ./open-file-explorer
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	start-process explorer.exe
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
