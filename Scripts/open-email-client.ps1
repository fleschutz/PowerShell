<#
.SYNOPSIS
	open-email-client.ps1
.DESCRIPTION
	Starts the default email client
.EXAMPLE
	PS> ./open-email-client
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	start-process "mailto:markus@fleschutz.de"
	exit 0
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
