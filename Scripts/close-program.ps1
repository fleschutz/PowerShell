<#
.SYNTAX       close-program.ps1 [<full-program-name>] [<program-name>] [<program-alias-name>]
.DESCRIPTION  closes the processes of the given program gracefully
.LINK         https://github.com/fleschutz/PowerShell
.NOTES        Author: Markus Fleschutz / License: CC0
#>

param($FullProgramName = "", $ProgramName = "", $ProgramAliasName = "")

if ($ProgramName -eq "") {
	get-process | where-object {$_.mainWindowTitle} | format-table Id, Name, mainWindowtitle -AutoSize
	$ProgramName = read-host "Enter program name"
}
if ($FullProgramName -eq "") {
	$FullProgramName = $ProgramName
}

try {
	$Processes = get-process -name $ProgramName -errorAction 'silentlycontinue'
	if ($Processes.Count -ne 0) {
		foreach ($Process in $Processes) {
			$Process.CloseMainWindow() | Out-Null
		} 
		start-sleep -milliseconds 100
		stop-process -name $ProgramName -force -errorAction 'silentlycontinue'
	} else {

		$Processes = get-process -name $ProgramAliasName -errorAction 'silentlycontinue'
		if ($Processes.Count -eq 0) {
			throw "$FullProgramName is not started yet"
		}
		foreach ($Process in $Processes) {
			$_.CloseMainWindow() | Out-Null
		} 
		start-sleep -milliseconds 100
		stop-process -name $ProgramName -force -errorAction 'silentlycontinue'
	}
	write-host -foregroundColor green "✔️ closed $FullProgramName, found ($($Processes.Count) process(es)"
	exit 0
} catch {
	write-error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
