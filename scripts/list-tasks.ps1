<#
.SYNOPSIS
	Lists all scheduled tasks
.DESCRIPTION
	This PowerShell script lists all scheduled tasks.
.EXAMPLE
	PS> ./list-tasks.ps1

	TASKNAME                          TASKPATH                             STATE           
	--------                          --------                             -----
	.NET Framework NGEN v4.0.30319    \Microsoft\Windows\.NET Framework\   Ready      
	...
.LINK
	https://github.com/fleschutz/PowerShell0
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	Get-ScheduledTask | Format-Table -property @{e='TASKNAME';width=40},@{e='TASKPATH';width=55},@{e='STATE';width=10}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
