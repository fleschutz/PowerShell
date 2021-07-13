<#
.SYNOPSIS
	list-clipboard.ps1
.DESCRIPTION
	Lists the contents of the clipboard
.EXAMPLE
	PS> .\list-clipboard.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	"📋 $(get-clipboard)"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
