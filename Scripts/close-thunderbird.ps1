<#
.SYNOPSIS
	Closes the Thunderbird app
.DESCRIPTION
	This script closes the Mozilla Thunderbird email application gracefully.
.EXAMPLE
	PS> ./close-thunderbird
.NOTES
	Author: Markus Fleschutz · License: CC0
.LINK
	https://github.com/fleschutz/PowerShell
#>

TaskKill /im thunderbird.exe
if ($lastExitCode -ne "0") {
	& "$PSScriptRoot/give-reply.ps1" "Sorry, Mozilla Thunderbird isn't running."
	exit 1
}
exit 0 # success
