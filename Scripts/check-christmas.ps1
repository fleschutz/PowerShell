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
	if ($Now -lt $Christmas) {
		$Diff = $Christmas – $Now
		& "$PSScriptRoot/give-reply.ps1" "Christmas on December 25 is in $($Diff.Days) days."
	} else {
		$Diff = $Now - $Christmas
		& "$PSScriptRoot/give-reply.ps1" "Christmas on December 25 was $($Diff.Days) days ago."
	}
	exit 0 # success
} catch {
	"⚠️ Error: $($Error[0]) ($($MyInvocation.MyCommand.Name):$($_.InvocationInfo.ScriptLineNumber))"
	exit 1
}
