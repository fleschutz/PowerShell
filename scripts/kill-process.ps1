<#
.SYNOPSIS
	Kills local processes
.DESCRIPTION
	This PowerShell script stops all local processes matching the given name
.PARAMETER processName
	Specifies the process name (ask user by default)
.EXAMPLE
	PS> ./kill-process.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$processName = "")

try {
	if ($processName -eq "") { $processName = Read-Host "Enter the process name" }
	Get-Process | Where-Object -FilterScript {$_.processname -eq $processName} | Select-Object id | Stop-Process
	"✔️ Stopped all processes matching '$processName'."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
