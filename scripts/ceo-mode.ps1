<#
.SYNOPSIS
	Enables the CEO mode
.DESCRIPTION
	This PowerShell script activates the CEO mode.
.EXAMPLE
	./ceo-mode.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	Clear-Host
	& "$PSScriptRoot/write-big.ps1" "CEO MODE"

	& "$PSScriptRoot/list-times.ps1"

	"⏳ Minimizing all windows..."
	& "$PSScriptRoot/minimize-all-windows.ps1"

	# Launch browser with useful tabs: tasks, calendar, world clock, notepad, nice background music
	& "$PSScriptRoot/open-URL.ps1" "https://tasks.google.com/tasks/"
	& "$PSScriptRoot/open-URL.ps1" "https://calendar.google.com/calendar/u/0/r/agenda"
	& "$PSScriptRoot/open-URL.ps1" "https://time.is/"
	& "$PSScriptRoot/open-URL.ps1" "https://notepad.js.org/"
	& "$PSScriptRoot/open-URL.ps1" "https://www.youtube.com/watch?v=TZgFg0Ok7W0&list=RDTZgFg0Ok7W0&start_radio=1&t=2229s"
	"⏳ Launching VPN settings..."
	& "$PSScriptRoot/open-vpn-settings.ps1"

	"⏳ Playing Big Ben and telling the current time..."
	& "$PSScriptRoot/play-big-ben.ps1"
	& "$PSScriptRoot/speak-time.ps1"

	& "$PSScriptRoot/show-notification.ps1" "CEO mode activated."
	"✅ CEO mode activated."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (in line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
