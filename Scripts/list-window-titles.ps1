<#
.SYNOPSIS
	Lists window titles
.DESCRIPTION
	This PowerShell script queries all main window titles and lists them as a table.
.EXAMPLE
	PS> ./list-window-titles.ps1

	   Id Name                 MainWindowTitle
	   -- ----                 ---------------
	11556 Spotify              Spotify Free
	...
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
