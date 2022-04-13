<#
.SYNOPSIS
	Opens the default email client to write a new email
.DESCRIPTION
	This PowerShell script opens the default email client to write a new email.
.PARAMETER EmailAddress
	Specifies the email address fill in
.EXAMPLE
	PS> ./new-email
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

param([string]$EmailAddress = "markus@fleschutz.de")

try {
	$URL="mailto:$EmailAddress"
	Start-Process $URL
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
