<#
.SYNTAX       open-file-explorer.ps1
.DESCRIPTION  starts the File Explorerer
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

try {
	start-process explorer.exe
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
