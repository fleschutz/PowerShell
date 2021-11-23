<#
.SYNOPSIS
	Opens the Windows taskbar settings 
.DESCRIPTION
	This script launches the Windows taskbar settings application.
.EXAMPLE
	PS> ./open-task-bar-settings
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

Start-Process ms-settings:taskbar
exit 0 # success
