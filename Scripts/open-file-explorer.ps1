<#
.SYNOPSIS
	open-file-explorer.ps1
.DESCRIPTION
	Starts the File Explorer.
.EXAMPLE
	PS> .\open-file-explorer.ps1
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	start-process explorer.exe
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
