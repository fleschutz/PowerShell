<#
.SYNOPSIS
	Closes the Thunderbird app
.DESCRIPTION
	This PowerShell script closes the Mozilla Thunderbird email application gracefully.
.EXAMPLE
	PS> ./close-thunderbird
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz / License: CC0
#>

TaskKill /im thunderbird.exe
if ($lastExitCode -ne "0") {
	& "$PSScriptRoot/give-reply.ps1" "Sorry, Mozilla Thunderbird isn't running."
	exit 1
}
exit 0 # success
