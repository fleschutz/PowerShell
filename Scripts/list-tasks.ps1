<#
.SYNOPSIS
	list-tasks.ps1 
.DESCRIPTION
	Lists all Windows scheduler tasks
.EXAMPLE
	PS> ./list-tasks

	TaskPath                                       TaskName                          State
	--------                                       --------                          -----
	\Microsoft\Windows\.NET Framework\             .NET Framework NGEN v4.0.30319    Ready
	\Microsoft\Windows\.NET Framework\             .NET Framework NGEN v4.0.30319 64 Ready
	...
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	Get-ScheduledTask
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
