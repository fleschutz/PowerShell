<#
.SYNOPSIS
	list-processes.ps1 
.DESCRIPTION
	Lists all local computer processes
.EXAMPLE
	PS> .\list-processes.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author:  Markus Fleschutz
	License: CC0
#>

try {
	Get-Process | Format-Table -Property Id, @{Label="CPU(s)";Expression={$_.CPU.ToString("N")+"%"};Alignment="Right"}, ProcessName -AutoSize
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
