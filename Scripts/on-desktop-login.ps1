<#
.SYNOPSIS
	Executes tasks on desktop login
.DESCRIPTION
	This PowerShell script executes tasks on every desktop login.
.EXAMPLE
	PS> ./on-desktop-login.ps1
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	& "$PSScriptRoot/open-dashboards.ps1"
	& "$PSScriptRoot/list-news.ps1"
	& "$PSScriptRoot/write-clock.ps1"
	exit 0 # success
} catch {
        "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
        exit 1
}
