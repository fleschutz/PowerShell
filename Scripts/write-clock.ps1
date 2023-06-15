<#
.SYNOPSIS
	Writes an ASCII clock
.DESCRIPTION
	This PowerShell script writes the current time as ACSII clock 
.EXAMPLE
	PS> ./write-clock
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	for ([int]$i = 0; $i -lt 99999; $i++) {
		Clear-Host
		Write-Output ""
		$Date = Get-Date -format "yyyy-MM-dd"
		$Time = Get-Date -format "HH:mm:ss" 
		& "$PSScriptRoot/write-big.ps1" $Date
		& "$PSScriptRoot/write-big.ps1" $Time
		Write-Output ""
		Start-Sleep -seconds 1
	}
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
