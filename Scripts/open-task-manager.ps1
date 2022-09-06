<#
.SYNOPSIS
	Starts the Task Manager
.DESCRIPTION
	This script launches the Windows Task Manager application.
.EXAMPLE
	PS> ./open-task-manager
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	Start-Process taskmgr.exe
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
