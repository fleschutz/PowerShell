<#
.SYNOPSIS
	Closes the Task Manager
.DESCRIPTION
	This script closes the Task Manager application gracefully.
.EXAMPLE
	PS> ./close-task-manager
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

& "$PSScriptRoot/close-program.ps1" "Task Manager" "Taskmgr" "Taskmgr.exe"
exit 0 # success
