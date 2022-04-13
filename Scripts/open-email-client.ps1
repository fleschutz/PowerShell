<#
.SYNOPSIS
	Starts the default email client
.DESCRIPTION
	This PowerShell script launches the default email client.
.EXAMPLE
	PS> ./open-email-client
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	start-process "mailto:markus@fleschutz.de"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
