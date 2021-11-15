<#
.SYNOPSIS
	Closes the OneCalendar app 
.DESCRIPTION
	This script closes the OneCalendar application gracefully.
.EXAMPLE
	PS> ./close-one-calendar
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

$result = TaskKill /f /im CalendarApp.Gui.Win10.exe
if ($result -ne 0) {
	& "$PSScriptRoot/speak-english.ps1" "Sorry, can't close OneCalendar"
	exit 1
}
exit 0 # success
