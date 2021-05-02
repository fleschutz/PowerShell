<#
.SYNTAX       moon.ps1
.DESCRIPTION  prints the current moon phase
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

try {
	(Invoke-WebRequest http://wttr.in/Moon -UserAgent "curl" ).Content
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
