<#
.SYNOPSIS
	Lists the contents of the clipboard
.DESCRIPTION
	This PowerShell script lists the contents of the clipboard.
.EXAMPLE
	PS> ./list-clipboard
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	"📋 $(get-clipboard)"
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
