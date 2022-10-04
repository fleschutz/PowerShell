<#
.SYNOPSIS
	Lists BIOS details
.DESCRIPTION
	This PowerShell script lists the BIOS details.
.EXAMPLE
	PS> ./list-bios
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	Get-CimInstance -ClassName Win32_BIOS
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}