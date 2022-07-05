<#
.SYNOPSIS
	Locks the desktop
.DESCRIPTION
	This PowerShell script locks the local computer desktop immediately.
.EXAMPLE
	PS> ./lock-desktop
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Bye bye."
	rundll32.exe user32.dll,LockWorkStation
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}