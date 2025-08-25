<#
.SYNOPSIS
	Creates a scheduled task that will display a popup message
.DESCRIPTION
	This PowerShell script creates a scheduled task that will display a popup message.
.EXAMPLE
	PS> ./remind-me "Dentist" "4/10/2021 12:00 PM"

	TaskPath                                       TaskName                          State
	--------                                       --------                          -----
	\                                              Reminder_451733811                Ready
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 4

param([string]$Message = "", [datetime]$Time)

try {
	if ($Message -eq "") { $Message = read-host "Enter reminder message" }

	$Task = New-ScheduledTaskAction -Execute msg -Argument "* $Message"
	$Trigger = New-ScheduledTaskTrigger -Once -At $Time
	$Random = (Get-Random)
	Register-ScheduledTask -Action $Task -Trigger $Trigger -TaskName "Reminder_$Random" -Description "Reminder"
	exit 0
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
