<#
.SYNOPSIS
	Executes tasks on desktop login
.DESCRIPTION
	This PowerShell script executes useful tasks on every desktop login by the user (e.g. open Web dashboards, list the news, fetch repos).
	NOTE: For installation on Windows create and put a symbolic link to this script into the Autostart folder (usually at: C:\Users\<USERNAME>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup).
.EXAMPLE
	PS> ./on-desktop-login.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
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
	& "$PSScriptRoot/write-clock.ps1"
	exit 0 # success
} catch {
        "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
        exit 1
}
