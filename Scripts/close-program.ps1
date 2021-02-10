#!/bin/powershell
<#
.SYNTAX         ./close-program.ps1 [<program-name>] [<full-program-name>]
.DESCRIPTION	closes the processes of the given program gracefully
.LINK		https://github.com/fleschutz/PowerShell
.NOTES		Author:	Markus Fleschutz / License: CC0
#>

param([string]$ProgramName = "", [string]$FullProgramName = "")

try {
	if ($ProgramName -eq "") {
		get-process | where-object {$_.mainWindowTitle} | format-table Id, Name, mainWindowtitle -AutoSize
		$ProgramName = read-host "Enter program name"
	}
	if ($FullProgramName -eq "") {
		$FullProgramName = $ProgramName
	}

	$Processes = get-process -name $ProgramName -errorAction 'silentlycontinue'
	foreach ($Process in $Processes) {
		$_.CloseMainWindow() | Out-Null
	} 
	start-sleep -milliseconds 100
	stop-process -name $ProgramName -force -errorAction 'silentlycontinue'

	$ProcessCount = $Processes.Count
	if ($ProcessCount -eq 0) {
		throw "$FullProgramName is not started yet"
	}
	write-host -foregroundColor green "Done - $FullProgramName with $ProcessCount process(es) has been closed."
	exit 0
} catch {
	write-error "ERROR in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
