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

taskkill /f /im CalendarApp.Gui.Win10.exe
exit 0 # success
