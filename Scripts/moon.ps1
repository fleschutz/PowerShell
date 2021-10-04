<#
.SYNOPSIS
	Prints the current moon phase
.DESCRIPTION
	moon.ps1
.EXAMPLE
	PS> ./moon
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	(Invoke-WebRequest http://wttr.in/Moon -UserAgent "curl" ).Content
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
