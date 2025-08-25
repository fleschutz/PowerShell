<#
.SYNOPSIS
	Lists CPU details
.DESCRIPTION
	This PowerShell script lists the CPU details.
.EXAMPLE
	PS> ./list-cpu.ps1

	Caption           : Intel64 Family 6 Model 94 Stepping 3
	DeviceID          : CPU0
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	Get-WmiObject -Class Win32_Processor
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
