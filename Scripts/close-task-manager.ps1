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

tskill taskmgr
exit 0 # success
