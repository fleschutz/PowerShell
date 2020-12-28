#!/snap/bin/powershell

# Syntax:       ./close-program.ps1 [<program-name>]
# Description:	closes the given program gracefully
# Author:	Markus Fleschutz
# Source:	github.com/fleschutz/PowerShell
# License:	CC0

param([string]$ProgramName)

try {
	if ($ProgramName -eq "" ) {
		Get-Process | Where-Object {$_.mainWindowTitle} | Format-Table Id, Name, mainWindowtitle -AutoSize
		$ProgramName = read-host "Enter program to close"
	}
	$List = Get-Process -name $ProgramName -erroraction 'silentlycontinue'
	$NumProcKilled = 0
	$List | Foreach-Object {
		$_.CloseMainWindow() | Out-Null
		$NumProcKilled++
	} | stop-process -force
	if ($NumProcKilled -eq 0) {
		throw "program '$ProgramName' is not started yet"
	}
	write-output "OK - program '$ProgramName' has been closed ($NumProcKilled processes)."
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
