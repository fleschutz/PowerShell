<#
.SYNOPSIS
	open-email-client.ps1
.DESCRIPTION
	Starts the default email client 
.EXAMPLE
	PS> .\open-email-client.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

try {
	start-process "mailto:markus@fleschutz.de"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
