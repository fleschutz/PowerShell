<#
.SYNOPSIS
	Plays the Mission Impossible theme
.DESCRIPTION
	This PowerShell script plays the Mission Impossible theme.
.EXAMPLE
	PS> ./play-mission-impossible.ps1
	(listen and enjoy)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	[System.Console]::Beep(784,150)
	Start-Sleep -m 300
	[System.Console]::Beep(784,150)
	Start-Sleep -m 300
	[System.Console]::Beep(932,150)
	Start-Sleep -m 150
	[System.Console]::Beep(1047,150)
	Start-Sleep -m 150
	[System.Console]::Beep(784,150)
	Start-Sleep -m 300
	[System.Console]::Beep(784,150)
	Start-Sleep -m 300
	[console]::Beep(699,150)
	Start-Sleep -m 150
	[System.Console]::Beep(740,150)
	Start-Sleep -m 150
	[System.Console]::Beep(784,150)
	Start-Sleep -m 300
	[System.Console]::Beep(784,150)
	Start-Sleep -m 300
	[System.Console]::Beep(932,150)
	Start-Sleep -m 150
	[System.Console]::Beep(1047,150)
	Start-Sleep -m 150
	[System.Console]::Beep(784,150)
	Start-Sleep -m 300
	[System.Console]::Beep(784,150)
	Start-Sleep -m 300
	[System.Console]::Beep(699,150)
	Start-Sleep -m 150
	[System.Console]::Beep(740,150)
	Start-Sleep -m 150
	[System.Console]::Beep(932,150)
	[System.Console]::Beep(784,150)
	[System.Console]::Beep(587,1200)
	Start-Sleep -m 75
	[System.Console]::Beep(932,150)
	[System.Console]::Beep(784,150)
	[System.Console]::Beep(554,1200)
	Start-Sleep -m 75
	[System.Console]::Beep(932,150)
	[System.Console]::Beep(784,150)
	[System.Console]::Beep(523,1200)
	Start-Sleep -m 150
	[System.Console]::Beep(466,150)
	[System.Console]::Beep(523,150)
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
