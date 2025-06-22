<#
.SYNOPSIS
	Kills all local processes matching the given name
.DESCRIPTION
	← enter a detailed description of the script here
.PARAMETER
	← enter the description of a parameter here (repeat the .PARAMETER for each parameter)
.EXAMPLE
	← enter a sample command that uses the script, optionally followed by sample output and a description (repeat the .EXAMPLE for each example)
.NOTES
	Author:        ← enter full name here
	License:       ← enter license here
.LINK
	← enter URL to additional information here
#>

[CmdletBinding()]
param(
#  [Parameter(Mandatory,ParameterSetName='ByProcessName')]
  [string]$ProcessName = $(Read-Host -Prompt 'Enter the process name'))

function KillProcesses {
	Write-Host -BackgroundColor Yellow -ForegroundColor Red "Process to kill: $ProcessName"  
	Get-Process | Where-Object -FilterScript {$_.processname -eq $ProcessName} | Select-Object id | Stop-Process
}


try {
	KillProcesses -ProcessName $processName
	"✔️ Done."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
