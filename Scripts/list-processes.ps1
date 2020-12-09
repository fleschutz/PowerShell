#!/snap/bin/powershell

# Syntax:	./list-processes.ps1 
# Description:	lists the local computer processes
# Author: 	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

try {
	Get-Process | Format-Table -Property Id, @{Label="CPU(s)";Expression={$_.CPU.ToString("N")+"%"};Alignment="Right"}, ProcessName -AutoSize
	exit 0
} catch {
	Write-Error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
