<#
.SYNOPSIS
	Prints the current moon phase
.DESCRIPTION
	This PowerShell script prints the current moon phase.
.EXAMPLE
	PS> ./moon
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	(Invoke-WebRequest http://wttr.in/Moon -userAgent "curl" -useBasicParsing).Content
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
