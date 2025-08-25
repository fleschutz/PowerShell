<#
.SYNOPSIS
	Closes a program
.DESCRIPTION
	This PowerShell script closes a program's processes gracefully.
.PARAMETER fullProgramName
	Specifies the full program name
.PARAMETER programName
	Specifies the program name
.PARAMETER programAliasName
	Specifies the program alias name
.EXAMPLE
	PS> ./close-program "Google Chrome" "chrome.exe"
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

param([string]$fullProgramName = "", [string]$programName = "", [string]$programAliasName = "")

try {
	if ($programName -eq "") {
		Get-Process | where-object {$_.mainWindowTitle} | format-table Id, Name, mainWindowtitle -AutoSize
		$programName = Read-Host "Enter the program name"
	}
	if ($fullProgramName -eq "") {
		$fullProgramName = $programName
	}

	$processes = Get-Process -name $programName -errorAction 'silentlycontinue'
	if ($processes.Count -ne 0) {
		foreach ($process in $processes) {
			$process.CloseMainWindow() | Out-Null
		} 
		Start-Sleep -milliseconds 100
		Stop-Process -name $programName -force -errorAction 'silentlycontinue'
	} else {
		$processes = Get-Process -name $programAliasName -errorAction 'silentlycontinue'
		if ($processes.Count -eq 0) {
			throw "$fullProgramName isn't running"
		}
		foreach ($process in $processes) {
			$_.CloseMainWindow() | Out-Null
		} 
		Start-Sleep -milliseconds 100
		Stop-Process -name $programName -force -errorAction 'silentlycontinue'
	}
	if ($($processes.Count) -eq 1) {
		"✅ $fullProgramName closed."
	} else {
		"✅ $fullProgramName closed and $($processes.Count) processes stopped."
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
