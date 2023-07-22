<#
.SYNOPSIS
	Hibernates the computer
.DESCRIPTION
	This PowerShell script hibernates the local computer immediately. 
.EXAMPLE
	PS> ./hibernate.ps1
	😴💤 Good night, I'm going to sleep deep...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	Write-Host "😴💤 Good night, I'm going to sleep deep..."
	& rundll32.exe powrprof.dll,SetSuspendState 1,1,0 # bHibernate,bForce,bWakeupEventsDisabled
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
