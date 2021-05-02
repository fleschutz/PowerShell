<#
.SYNTAX       open-recycle-bin.ps1 
.DESCRIPTION  starts the File Explorer with the recycle bin folder
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

try {
	start shell:recyclebinfolder
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
