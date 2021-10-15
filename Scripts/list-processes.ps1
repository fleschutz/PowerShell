<#
.SYNOPSIS
	Lists all local computer processes
.DESCRIPTION
	This script lists all local computer processes.
.EXAMPLE
	PS> ./list-processes

	   Id  CPU(s) ProcessName
	   --  ------ -----------
	 9712   0,39% 64DriverLoad
	 2484         AppleMobileDeviceService
	 ...
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	Get-Process | Format-Table -Property Id, @{Label="CPU(s)";Expression={$_.CPU.ToString("N")+"%"};Alignment="Right"}, ProcessName -AutoSize
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
