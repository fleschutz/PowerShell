<#
.SYNOPSIS
	remind-me.ps1
.DESCRIPTION
	Creates a scheduled task that will display a message.
.EXAMPLE
	PS> ./remind-me "Dentist" "1/1/2016 12:00 PM"
	✔ OK
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

#requires -version 4

param([string]$Message = "", [datetime]$Time)

try {
	if ($Message -eq "") { $Message = read-host "Enter message to display" }

	$Task = New-ScheduledTaskAction -Execute msg -Argument "* $Message"
	$Trigger = New-ScheduledTaskTrigger -Once -At $Time
	$Random = (Get-Random)
	Register-ScheduledTask -Action $Task -Trigger $Trigger -TaskName "Reminder_$Random" -Description "Reminder"
	"✔️ OK"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
