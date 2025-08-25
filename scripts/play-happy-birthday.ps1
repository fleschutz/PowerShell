<#
.SYNOPSIS
	Plays the Happy Birthday song
.DESCRIPTION
	This PowerShell script plays the famous Happy Birthday song.
.EXAMPLE
	PS> ./play-happy-birthday.ps1
	(listen and enjoy)
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	[System.Console]::Beep(1059.274, 300)
	[System.Console]::Beep(1059.274, 200)
	[System.Console]::Beep(1188.995, 500)
	[System.Console]::Beep(1059.274, 500)
	[System.Console]::Beep(1413.961, 500)
	[System.Console]::Beep(1334.601, 950)
	[System.Console]::Beep(1059.274, 300)
	[System.Console]::Beep(1059.274, 200)
	[System.Console]::Beep(1188.995, 500)
	[System.Console]::Beep(1059.274, 500)
	[System.Console]::Beep(1587.117, 500)
	[System.Console]::Beep(1413.961, 950)
	[System.Console]::Beep(1059.274, 300)
	[System.Console]::Beep(1059.274, 200)
	[System.Console]::Beep(2118.547, 500)
	[System.Console]::Beep(1781.479, 500)
	[System.Console]::Beep(1413.961, 500)
	[System.Console]::Beep(1334.601, 500)
	[System.Console]::Beep(1188.995, 500)
	[System.Console]::Beep(1887.411, 300)
	[System.Console]::Beep(1887.411, 200)
	[System.Console]::Beep(1781.479, 500)
	[System.Console]::Beep(1413.961, 500)
	[System.Console]::Beep(1587.117, 500)
	[System.Console]::Beep(1413.961, 900)
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
