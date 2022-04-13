<#
.SYNOPSIS
	Lists all local computer processes
.DESCRIPTION
	This PowerShell script lists all local computer processes.
.EXAMPLE
	PS> ./list-processes

	   Id  CPU(s) ProcessName
	   --  ------ -----------
	 9712   0,39% 64DriverLoad
	 2484         AppleMobileDeviceService
	 ...
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

try {
	Get-Process | Format-Table -Property Id, @{Label="CPU(s)";Expression={$_.CPU.ToString("N")+"%"};Alignment="Right"}, ProcessName -AutoSize
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
