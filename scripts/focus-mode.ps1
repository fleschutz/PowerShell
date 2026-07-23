<#
.SYNOPSIS
	Enables the focus mode
.DESCRIPTION
	This PowerShell script activates the focus mode.
.EXAMPLE
	./focus-mode.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

#requires -version 5.1

try {
	Clear-Host
	& "$PSScriptRoot/write-big.ps1" "FOCUS MODE"

	& "$PSScriptRoot/list-times.ps1"

	"⏳ Minimizing all windows..."
	& "$PSScriptRoot/minimize-all-windows.ps1"

	& "$PSScriptRoot/open-URL.ps1" "https://www.youtube.com/watch?v=TZgFg0Ok7W0&list=RDTZgFg0Ok7W0&start_radio=1&t=2229s"

	"⏳ Playing Big Ben..."
	& "$PSScriptRoot/play-big-ben.ps1"

	"⏳ Telling the current time..."
	& "$PSScriptRoot/speak-time.ps1"

	"⏳ Launching VPN settings..."
	& "$PSScriptRoot/open-vpn-settings.ps1"

	& "$PSScriptRoot/show-notification.ps1" "Focus mode activated."
	"✅ Focus mode activated."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (in line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
