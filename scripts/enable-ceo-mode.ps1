<#
.SYNOPSIS
	Enables CEO mode
.DESCRIPTION
	This PowerShell script enables the CEO mode.
.EXAMPLE
	./enable-ceo-mode.ps1
#>

#requires -version 5.1

try {
	Clear-Host
	& "$PSScriptRoot/write-big.ps1" "CEO MODE"

	& "$PSScriptRoot/list-times.ps1"
	& "$PSScriptRoot/speak-english.ps1" "Just a second."

	"⏳ Minimizing all windows..."
	& "$PSScriptRoot/minimize-all-windows.ps1"

	& "$PSScriptRoot/open-dashboards.ps1"

	"⏳ Playing Big Ben..."
	& "$PSScriptRoot/play-big-ben.ps1"

	"⏳ Tell the time..."
	& "$PSScriptRoot/speak-time.ps1"

	"⏳ Open VPN settings..."
	& "$PSScriptRoot/open-vpn-settings.ps1"

	& "$PSScriptRoot/show-notification.ps1" "CEO mode enabled."
	"✅ CEO mode enabled."
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (in line $($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
