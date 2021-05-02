<#
.SYNTAX       list-clipboard.ps1
.DESCRIPTION  lists the contents of the clipboard
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

try {
	"📋 $(get-clipboard)"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
