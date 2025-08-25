<#
.SYNOPSIS
	Writes an ASCII clock
.DESCRIPTION
	This PowerShell script writes the current time as ASCII clock.
.EXAMPLE
	PS> ./write-clock.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	[system.threading.thread]::currentthread.currentculture = [system.globalization.cultureinfo]"en-US"
	$Weekday = Get-Date -UFormat "%A"
	$Date = Get-Date -UFormat "%d %b %Y"
	$Week = Get-Date -UFormat "%V"

	Clear-Host
	& "$PSScriptRoot/write-big.ps1" "    $Weekday"
	Write-Output ""
	& "$PSScriptRoot/write-big.ps1" "  $Date"
	Write-Output ""
	& "$PSScriptRoot/write-big.ps1" "    WEEK $Week"
	Write-Output ""

	$StartPosition = $HOST.UI.RawUI.CursorPosition
	while ($true) {
		$Time = Get-Date -format "HH:mm:ss" 
		& "$PSScriptRoot/write-big.ps1" "    $Time  "
		Write-Output "`n                             (press <Ctrl> <C> to stop)"
		Start-Sleep -seconds 1
		$HOST.UI.RawUI.CursorPosition = $StartPosition
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
