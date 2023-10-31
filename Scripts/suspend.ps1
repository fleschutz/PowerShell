<#
.SYNOPSIS
	Suspends the computer
.DESCRIPTION
	This PowerShell script suspends the local computer immediately.
.EXAMPLE
	PS> ./suspend
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"Bye bye."
	& rundll32.exe powrprof.dll,SetSuspendState 0,1,0 # bHibernate,bForce,bWakeupEventsDisabled
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}