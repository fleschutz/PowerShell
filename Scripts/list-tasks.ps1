<#
.SYNOPSIS
	Lists all scheduled tasks
.DESCRIPTION
	This PowerShell script lists all scheduled tasks.
.EXAMPLE
	PS> ./list-tasks

	TaskName                            State  TaskPath                                       
	--------                            -----  --------
	.NET Framework NGEN v4.0.30319      Ready  \Microsoft\Windows\.NET Framework\             
	.NET Framework NGEN v4.0.30319 64   Ready  \Microsoft\Windows\.NET Framework\             
	...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	Get-ScheduledTask | Format-Table -property TaskName,State,TaskPath
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
