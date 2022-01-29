<#
.SYNOPSIS
	Closes the OneCalendar app 
.DESCRIPTION
	This PowerShell script closes the OneCalendar application gracefully.
.EXAMPLE
	PS> ./close-one-calendar
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

TaskKill /f /im CalendarApp.Gui.Win10.exe
if ($lastExitCode -ne "0") {
	& "$PSScriptRoot/give-reply.ps1" "Sorry, OneCalendar isn't running."
	exit 1
}
exit 0 # success
