<#
.SYNOPSIS
	Launches the Skype app
.DESCRIPTION
	This script launches the Skype application.
.EXAMPLE
	PS> ./open-skype
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	start-process skype:
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
