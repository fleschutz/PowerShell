<#
.SYNOPSIS
	Writes 'Hands Off'
.DESCRIPTION
	This PowerShell script writes 'Hands Off' in BIG letters.
.EXAMPLE
	PS> ./write-hands-off.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	$randomNumberGenerator = New-Object System.Random
	while ($true) {
		Clear-Host
		Write-Host "`n`n"
		& "$PSScriptRoot/write-big.ps1" "     HANDS OFF"
		Write-Host "`n`n"
		& "$PSScriptRoot/write-big.ps1" "   DO NOT TOUCH"
		Write-Host "`n`n"
		& "$PSScriptRoot/write-big.ps1" "       MY PC"
		[int]$x = $randomNumberGenerator.next(1, 90)
		[int]$y = $randomNumberGenerator.next(1, 22)
		[System.Console]::SetCursorPosition($x, $y)
		Write-Host "🔥🔥🔥 LAST WARNING 🔥🔥🔥" -foregroundColor red
		Start-Sleep -milliseconds 900
	}
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
