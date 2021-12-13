<#
.SYNOPSIS
	Checks the time until Christmas
.DESCRIPTION
	This script checks the time until Christmas and replies by text-to-speech (TTS).
.EXAMPLE
	PS> ./check-christmas
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

try {
	$Now = [DateTime]::Now
	$Christmas = [Datetime]("12/25/" + $Now.Year)
	$Days = ($Christmas - $Now).Days
	if ($Days -gt 1) {
		& "$PSScriptRoot/give-reply.ps1" "Christmas is in $Days days."
	} elseif ($Days -eq 1) {
		& "$PSScriptRoot/give-reply.ps1" "Christmas is tomorrow."
	} elseif ($Days -eq 0) {
		& "$PSScriptRoot/give-reply.ps1" "Christmas is today."
	} elseif ($Days -eq 1) {
		& "$PSScriptRoot/give-reply.ps1" "Christmas is tomorrow."
	} elseif ($Days -eq -1) {
		& "$PSScriptRoot/give-reply.ps1" "Christmas was yesterday."
	} else {
		$Days = -$Days
		& "$PSScriptRoot/give-reply.ps1" "Christmas was $Days days ago."
	}
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
