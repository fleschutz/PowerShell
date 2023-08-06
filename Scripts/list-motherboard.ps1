<#
.SYNOPSIS
	Lists motherboard details
.DESCRIPTION
	This PowerShell script lists the motherboard details.
.EXAMPLE
	PS> ./list-motherboard.ps1

	Manufacturer : Gigabyte Technology Co., Ltd.
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	Get-WmiObject -Class Win32_BaseBoard
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
