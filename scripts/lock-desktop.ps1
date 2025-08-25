<#
.SYNOPSIS
	Locks the desktop
.DESCRIPTION
	This PowerShell script locks the local computer desktop immediately.
.EXAMPLE
	PS> ./lock-desktop.ps1
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
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
