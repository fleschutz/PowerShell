<#
.SYNOPSIS
	Lists window titles
.DESCRIPTION
	This PowerShell script list all main window titles and displays them in a table.
.EXAMPLE
	PS> ./list-window-titles
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	Get-Process | Where-Object {$_.mainWindowTitle} | Format-Table Id,Name,mainWindowtitle -AutoSize
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}