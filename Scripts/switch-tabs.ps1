<#
.SYNOPSIS
	Presses the Next Tab hotkey
.DESCRIPTION
	This PowerShell script presses the Next Tab keyboard shortcuts.
.EXAMPLE
	PS> ./switch-tabs
.NOTES
	Author:  Markus Fleschutz / License: CC0
.LINK
	https://github.com/fleschutz/talk2windows
#>

param([int]$Interval = 5) # in seconds

try {
	Write-Host "Switching browser tabs every $Interval seconds (press Ctrl + C to stop it)..." -noNewline
	$obj = New-Object -com wscript.shell
	for ([int]$i = 0; $i -lt 1000; $i++) {
		Write-Host "." -noNewline
		$obj.SendKeys("^{PGDN}")
		Start-Sleep -seconds $Interval
	}
	exit 0 # success
} catch {
	& "$PSScriptRoot/_reply.ps1" "Sorry: $($Error[0])"
	exit 1
}
