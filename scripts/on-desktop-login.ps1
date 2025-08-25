<#
.SYNOPSIS
	Executes tasks on desktop login
.DESCRIPTION
	This PowerShell script executes some 'welcome' tasks on every desktop login by the user.
	NOTE: for installation on Windows create and put a symbolic link to this script into the Autostart folder (usually at: C:\Users\<USERNAME>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup).
.EXAMPLE
	PS> ./on-desktop-login.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	" "
	& "$PSScriptRoot/check-uptime.ps1"
	& "$PSScriptRoot/check-pending-reboot.ps1"
	& "$PSScriptRoot/check-firewall.ps1"
	& "$PSScriptRoot/check-smart-devices.ps1"
	& "$PSScriptRoot/check-swap-space.ps1"
	& "$PSScriptRoot/check-drives.ps1"
	& "$PSScriptRoot/open-dashboards.ps1"
	" "
	& "$PSScriptRoot/write-quote.ps1"
	" "
	& "$PSScriptRoot/list-news.ps1"
	" "
	& "$PSScriptRoot/write-joke.ps1"
	" "
	& "$PSScriptRoot/cd-repos.ps1"
	& "$PSScriptRoot/fetch-repos.ps1"
	" "
	& "$PSScriptRoot/watch-news.ps1"
	exit 0 # success
} catch {
	"⚠️ ERROR: $($Error[0]) (script line $($_.InvocationInfo.ScriptLineNumber))"
        exit 1
}
