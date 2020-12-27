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
	$NumProc = 0
	$List | Foreach-Object { $NumProc++; $_.CloseMainWindow() | Out-Null } | stop-process -force
	if ($NumProc -eq 0) {
		write-error "ERROR: No processes for program '$ProgramName' found"
		exit 1
	} else {
		write-output "Done - $NumProc processes stopped."
		exit 0
	}
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
