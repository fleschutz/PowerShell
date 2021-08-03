<#
.SYNOPSIS
	open-file-explorer.ps1
.DESCRIPTION
	Starts the File Explorerer
.EXAMPLE
	PS> .\open-file-explorer.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

try {
	start-process explorer.exe
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
