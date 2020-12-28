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

	$Processes = Get-Process -name $ProgramName -erroraction 'silentlycontinue'
	foreach ($Process in $Processes) {
		$_.CloseMainWindow() | Out-Null
	} 
	start-sleep -milliseconds 100
	Stop-Process -name $ProgramName -force -erroraction 'silentlycontinue'

	$ProcessCount = $Processes.Count
	if ($ProcessCount -eq 0) {
		throw "program '$ProgramName' is not started yet"
	}
	write-output "OK - program '$ProgramName' with $ProcessCount process(es) has been closed."
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
